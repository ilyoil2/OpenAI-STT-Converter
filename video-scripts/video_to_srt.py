import argparse
import os
import sys
from datetime import date
from pathlib import Path

from faster_whisper import WhisperModel


def format_timestamp(seconds):
    milliseconds_total = round(seconds * 1000)
    hours, remainder = divmod(milliseconds_total, 3_600_000)
    minutes, remainder = divmod(remainder, 60_000)
    secs, milliseconds = divmod(remainder, 1000)
    return f"{hours:02d}:{minutes:02d}:{secs:02d},{milliseconds:03d}"


def transcribe_to_srt_local(
    input_file_path,
    srt_output_path="output.srt",
    model_size="base",
    language="ja",
):
    print(f"🎙️ 로컬 영상/오디오 파일 ({input_file_path.name}) 변환 시작...")
    print("🎙️ Whisper 모델 로딩 중... (CPU 사용)")

    model = WhisperModel(
        model_size,
        device="cpu",
        compute_type="int8",
        cpu_threads=os.cpu_count() or 4,
    )
    
    segments, info = model.transcribe(
        str(input_file_path),
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


def default_srt_path(input_path, save_dir="saves"):
    return Path(save_dir) / f"{date.today().isoformat()}_{Path(input_path).stem}.srt"


def parse_args():
    parser = argparse.ArgumentParser(
        description="Create an SRT file from a local video/audio file using local Whisper."
    )
    parser.add_argument("file", help="Path to the local video or audio file")
    parser.add_argument(
        "-o",
        "--output",
        help="Output SRT path. Defaults to saves/YYYY-MM-DD_filename.srt",
    )
    parser.add_argument("-l", "--language", default="ja", help="Language code, e.g. ja, ko, en")
    parser.add_argument(
        "-m",
        "--model",
        default="base",
        choices=["tiny", "base", "small", "medium", "large-v3"],
        help="Whisper model size",
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    input_file = Path(args.file)

    if not input_file.exists():
        print(f"❌ 파일을 찾을 수 없습니다: {input_file}")
        sys.exit(1)

    try:
        output_path = args.output or default_srt_path(input_file)
        transcribe_to_srt_local(
            input_file,
            output_path,
            model_size=args.model,
            language=args.language,
        )

    except Exception as e:
        print(f"❌ 오류가 발생했습니다: {e}")
        sys.exit(1)
