import argparse
import os
import sys
from datetime import date
from pathlib import Path

import yt_dlp
from faster_whisper import WhisperModel


def download_audio(youtube_url, output_dir="downloads"):
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    ydl_opts = {
        "format": "bestaudio/best",
        "outtmpl": str(output_path / "%(title).180B.%(ext)s"),
        "noplaylist": True,
        "restrictfilenames": True,
        "postprocessors": [
            {
                "key": "FFmpegExtractAudio",
                "preferredcodec": "mp3",
                "preferredquality": "192",
            }
        ],
    }

    print('🎬 yt-dlp -x --audio-format mp3 방식으로 오디오 다운로드 중...')
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(youtube_url, download=True)
        audio_path = Path(ydl.prepare_filename(info)).with_suffix(".mp3")

    if not audio_path.exists():
        raise FileNotFoundError(f"다운로드된 MP3 파일을 찾을 수 없습니다: {audio_path}")

    print(f"✅ MP3 다운로드 완료: {audio_path}")
    return audio_path


def format_timestamp(seconds):
    milliseconds_total = round(seconds * 1000)
    hours, remainder = divmod(milliseconds_total, 3_600_000)
    minutes, remainder = divmod(remainder, 60_000)
    secs, milliseconds = divmod(remainder, 1000)
    return f"{hours:02d}:{minutes:02d}:{secs:02d},{milliseconds:03d}"


def transcribe_to_srt_local(
    audio_file_path,
    srt_output_path="output.srt",
    model_size="base",
    language="ja",
):
    print("🎙️ 로컬 Whisper 모델 로딩 및 STT 작업 시작... (이 작업은 무료입니다)")

    model = WhisperModel(
        model_size,
        device="cpu",
        compute_type="int8",
        cpu_threads=os.cpu_count() or 4,
    )
    segments, info = model.transcribe(
        str(audio_file_path),
        language=language,
        vad_filter=True,
    )

    print(f"Detected language '{info.language}' with probability {info.language_probability:.2f}")

    output_path = Path(srt_output_path)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    subtitle_index = 1
    with output_path.open("w", encoding="utf-8") as f:
        for segment in segments:
            text = segment.text.strip()
            if not text:
                continue

            start_time = format_timestamp(segment.start)
            end_time = format_timestamp(segment.end)

            f.write(f"{subtitle_index}\n")
            f.write(f"{start_time} --> {end_time}\n")
            f.write(f"{text}\n\n")
            subtitle_index += 1

    print(f"✅ 자막 파일 생성 완료: {output_path}")


def default_srt_path(audio_path, save_dir="saves"):
    return Path(save_dir) / f"{date.today().isoformat()}_{Path(audio_path).stem}.srt"


def parse_args():
    parser = argparse.ArgumentParser(
        description="Download YouTube audio and create an SRT file with local Whisper."
    )
    parser.add_argument("url", help="YouTube URL")
    parser.add_argument(
        "-o",
        "--output",
        help="Output SRT path. Defaults to saves/YYYY-MM-DD_video-title.srt",
    )
    parser.add_argument("-l", "--language", default="ja", help="Language code, e.g. ja, ko, en")
    parser.add_argument(
        "-m",
        "--model",
        default="base",
        choices=["tiny", "base", "small", "medium", "large-v3"],
        help="Whisper model size",
    )
    parser.add_argument(
        "--download-dir",
        default="downloads",
        help="Directory for downloaded MP3 files",
    )
    parser.add_argument(
        "--keep-audio",
        action="store_true",
        help="Keep the downloaded MP3 file after transcription",
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    actual_audio_path = None

    try:
        actual_audio_path = download_audio(args.url, args.download_dir)
        output_path = args.output or default_srt_path(actual_audio_path)
        transcribe_to_srt_local(
            actual_audio_path,
            output_path,
            model_size=args.model,
            language=args.language,
        )

    except Exception as e:
        print(f"❌ 오류가 발생했습니다: {e}")
        sys.exit(1)
    finally:
        if actual_audio_path and not args.keep_audio:
            Path(actual_audio_path).unlink(missing_ok=True)
