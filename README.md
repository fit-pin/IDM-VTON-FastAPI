# IDM-VTON-FastAPI
 [yisol/IDM-VTON](https://github.com/yisol/IDM-VTON)의 자체 FastAPI 서버 구현 본


## 사용법

### Docker 사용

1. Dockerfile 이미지 빌드

    ```bash
    docker buildx build --load -t fitpin .
    ```


2. 컨테이너 생성 & 실행

    ```bash
    docker run -it --name fitpin -p 8080:8080 --gpus all fitpin
    ```

### 로컬

1.  `first-setting.py` 실행
    
    - 처음 시작시 로드 문제로 `gradio_demo`를 한번 import 하여 Huggingface 모델을 다운로드 받음

    ```bash
    python first-setting.py
    ```

2. 서버 시작 

    ```bash
    uvicorn Server:server --reload --port 80 --host 0.0.0.0
    ```