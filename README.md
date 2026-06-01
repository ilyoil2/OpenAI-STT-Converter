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

영상 MP4 다운로드:

```bash
./download-video "YOUTUBE_URL"
```

일본어 Small:

```bash
./transcribe-ja-small "YOUTUBE_URL"
```

일본어 Medium:

```bash
./transcribe-ja-medium "YOUTUBE_URL"
```

영어 Small:

```bash
./transcribe-en-small "YOUTUBE_URL"
```

영어 Medium:

```bash
./transcribe-en-medium "YOUTUBE_URL"
```

`-o`를 생략하면 SRT는 `saves/YYYY-MM-DD_영상제목.srt` 형식으로 저장됩니다. 시간은 파일명에 넣지 않습니다.

원하는 경로를 직접 지정할 수도 있습니다.

```bash
./transcribe-ja-small "YOUTUBE_URL" -o saves/custom_name.srt
```

동작 흐름은 아래와 같습니다.

```bash
yt-dlp -x --audio-format mp3 "YOUTUBE_URL"
```

위 방식으로 `downloads/` 폴더에 MP3를 받은 뒤, 그 MP3를 로컬 `faster-whisper`가 읽어서 SRT로 변환합니다.
기본 설정에서는 SRT 생성 후 다운로드한 MP3를 삭제합니다.

MP3를 남기고 싶으면 `--keep-audio`를 사용합니다.

```bash
./transcribe-ja-small "YOUTUBE_URL" --keep-audio
```

모델 크기는 `tiny`, `base`, `small`, `medium`, `large-v3` 중에서 고를 수 있습니다.

```bash
.venv/bin/python youtube_to_srt.py "YOUTUBE_URL" -l ja -m small
```
