# 로컬 영상 자막 변환 방법

로컬에 있는 `.mov`, `.mp4` 등의 영상 파일에서 자막을 추출합니다.

### 실행 명령어
```bash
.venv/bin/python video-scripts/video_to_srt.py "영상_파일_경로" -l ja -m small
```

### 옵션 설명
- `-l ja`: 일본어 (한국어는 `-l ko`, 영어는 `-l en`)
- `-m small`: 모델 크기 (속도/정확도 밸런스 권장)

* 생성된 자막은 **`saves/`** 폴더에 저장됩니다.
