import argparse
from pathlib import Path

import yt_dlp
from faster_whisper import WhisperModel


def download_audio(youtube_url, output_dir="downloads"):
    """
    yt-dlp -x --audio-format mp3 "<유튜브_URL>" 흐름으로 MP3를 저장합니다.
    """
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
    """
    초 단위 시간을 SRT 포맷(HH:MM:SS,mmm)으로 변환합니다.
    """
    hours = int(seconds // 3600)
    minutes = int((seconds % 3600) // 60)
    secs = int(seconds % 60)
    milliseconds = int((seconds - int(seconds)) * 1000)
    return f"{hours:02d}:{minutes:02d}:{secs:02d},{milliseconds:03d}"


def transcribe_to_srt_local(
    audio_file_path,
    srt_output_path="output.srt",
    model_size="base",
    language="ja",
):
    """
    맥북 로컬에서 동작하는 faster-whisper를 이용해 SRT 자막을 생성합니다.
    """
    print("🎙️ 로컬 Whisper 모델 로딩 및 STT 작업 시작... (이 작업은 무료입니다)")
    
    # 모델 사이즈 선택: tiny, base, small, medium, large-v3 등이 있습니다.
    # 맥북에어 M2에서는 'base'나 'small'이 속도와 정확도 밸런스가 가장 좋습니다.
    # Apple Silicon(M시렬)의 CPU/기본 가속을 활용하기 위해 cpu를 지정합니다.
    model = WhisperModel(model_size, device="cpu", compute_type="float32")
    
    # 언어를 명시하여 정확도를 높입니다. 일본어는 'ja', 한국어는 'ko', 영어는 'en'입니다.
    segments, info = model.transcribe(audio_file_path, language=language)
    
    print(f"Detected language '{info.language}' with probability {info.language_probability:.2f}")
    
    # SRT 파일 쓰기
    with open(srt_output_path, "w", encoding="utf-8") as f:
        for i, segment in enumerate(segments, start=1):
            start_time = format_timestamp(segment.start)
            end_time = format_timestamp(segment.end)
            text = segment.text.strip()
            
            # SRT 표준 포맷에 맞게 기록
            f.write(f"{i}\n")
            f.write(f"{start_time} --> {end_time}\n")
            f.write(f"{text}\n\n")
            
    print(f"✅ 자막 파일 생성 완료: {srt_output_path}")


def parse_args():
    parser = argparse.ArgumentParser(
        description="Download YouTube audio and create an SRT file with local Whisper."
    )
    parser.add_argument("url", help="YouTube URL")
    parser.add_argument("-o", "--output", default="subtitle.srt", help="Output SRT path")
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
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    
    try:
        # Step 1: 음성 다운로드 (유튜브 -> MP3)
        actual_audio_path = download_audio(args.url, args.download_dir)
        
        # Step 2: 맥북 로컬 자원으로 STT 및 SRT 자막 생성
        transcribe_to_srt_local(
            actual_audio_path,
            args.output,
            model_size=args.model,
            language=args.language,
        )
        
    except Exception as e:
        print(f"❌ 오류가 발생했습니다: {e}")
