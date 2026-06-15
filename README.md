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

자세한 사용법은 [사용 가이드 (USAGE.md)](./USAGE.md)를 참고해 주세요!

### YouTube 영상 자막 만들기

```bash
./yt-scripts/download-video "YOUTUBE_URL"
```

영상 일부만 다운로드

```bash
./yt-scripts/download-video "YOUTUBE_URL" "00:00" to "1:01:00"
```

일본어 Small:

```bash
./yt-scripts/transcribe-ja-small "YOUTUBE_URL"
```

일본어 Medium:

```bash
./yt-scripts/transcribe-ja-medium "YOUTUBE_URL"
```

영어 Small:

```bash
./yt-scripts/transcribe-en-small "YOUTUBE_URL"
```

영어 Medium:

```bash
./yt-scripts/transcribe-en-medium "YOUTUBE_URL"
```

`-o`를 생략하면 SRT는 `saves/YYYY-MM-DD_영상제목.srt` 형식으로 저장됩니다. 시간은 파일명에 넣지 않습니다.

원하는 경로를 직접 지정할 수도 있습니다.

```bash
./yt-scripts/transcribe-ja-small "YOUTUBE_URL" -o saves/custom_name.srt
```

동작 흐름은 아래와 같습니다.

```bash
yt-dlp -x --audio-format mp3 "YOUTUBE_URL"
```

위 방식으로 `downloads/` 폴더에 MP3를 받은 뒤, 그 MP3를 로컬 `faster-whisper`가 읽어서 SRT로 변환합니다.
기본 설정에서는 SRT 생성 후 다운로드한 MP3를 삭제합니다.

MP3를 남기고 싶으면 `--keep-audio`를 사용합니다.

```bash
./yt-scripts/transcribe-ja-small "YOUTUBE_URL" --keep-audio
```

모델 크기는 `tiny`, `base`, `small`, `medium`, `large-v3` 중에서 고를 수 있습니다.

```bash
.venv/bin/python yt-scripts/record_to_srt.py "YOUTUBE_URL" -l ja -m small
```

## Local Video Transcription

로컬에 있는 영상(.mov, .mp4 등)이나 오디오 파일에서 자막을 생성합니다.

```bash
.venv/bin/python video-scripts/video_to_srt.py "LOCAL_FILE_PATH" -l ja -m small
```

`-o`를 생략하면 SRT는 `saves/YYYY-MM-DD_파일명.srt` 형식으로 저장됩니다.

프로젝트 진행을 위해서는, 
1. migrate
2. kanjify_data download
3. remove_duplicates
4. remove 𢖻 <- 확장한자 대체 (extension_characters.md 확인)
SELECT *
FROM tbl_kanji
WHERE etymology LIKE '%𢖻%';
5. tbl_voca 단어 level 설정 (assign_jlpt_levels.py 확인)
pt_levels.py 확인)


프로젝트 진행을 위해서는, 
0. migrate
1. kanjify_data.py 실행 : yanki 데이터 다운로드
2. insert_kanji.sql, cleanup_data.sql 실행 : 데이터 정제
3. extension_characters.md 실행 : 한자 수정 (글꼴 꺠진 한자 𢖻)
4. update_jlpt_level.py 실행 : tbl_voca 단어 level 설정
5. 4번에서 미초함 2천자 level 직접 넣어주기 (ai 활용)