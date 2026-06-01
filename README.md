# OpenAI-STT-Converter

YouTube 영상의 오디오를 다운로드한 뒤 로컬 Whisper로 SRT 자막을 생성하는 스크립트입니다.

## Setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

`ffmpeg`와 `ffprobe`가 필요합니다. macOS에서는 보통 아래 명령으로 설치합니다.

```bash
brew install ffmpeg
```

## Usage

로컬 Whisper 사용:

```bash
./transcribe "https://www.youtube.com/watch?v=VIDEO_ID" -o output.srt -l ja
```

Small 모델 고정:

```bash
./transcribe-small "https://www.youtube.com/watch?v=VIDEO_ID" -o output.srt -l ja
```

Medium 모델 고정:

```bash
./transcribe-medium "https://www.youtube.com/watch?v=VIDEO_ID" -o output.srt -l ja
```

동작 흐름은 아래와 같습니다.

```bash
yt-dlp -x --audio-format mp3 "https://www.youtube.com/watch?v=VIDEO_ID"
```

위 방식으로 `downloads/` 폴더에 MP3를 받은 뒤, 그 MP3를 로컬 `faster-whisper`가 읽어서 SRT로 변환합니다.

모델 크기는 `tiny`, `base`, `small`, `medium`, `large-v3` 중에서 고를 수 있습니다.

```bash
./transcribe "https://www.youtube.com/watch?v=VIDEO_ID" -o output.srt -l ja -m small
```
