# IDM-VTON-FastAPI
[yisol/IDM-VTON](https://github.com/yisol/IDM-VTON)의 자체 FastAPI 서버 구현 본

- [fitpin_backend_ar `try-on` API](https://github.com/fit-pin/fitpin_backend_ar?tab=readme-ov-file#post-try-on-%EC%B1%84%ED%98%95-%EC%82%AC%EC%A7%84%EA%B3%BC-%EC%9D%98%EB%A5%98-%EC%9D%B4%EB%AF%B8%EC%A7%80%EA%B0%80-%ED%95%A9%EC%84%B1%EB%90%9C-%EC%9D%B4%EB%AF%B8%EC%A7%80%EB%A5%BC-%EB%A6%AC%ED%84%B4%ED%95%A9%EB%8B%88%EB%8B%A4) 에 처리를 담당 하는 서버

## API 

### [**POST**] [/api/idm](https://fitpin.kro.kr/ar-idm-api/api/idm/)

- [Swagger 테스트](https://fitpin.kro.kr/ar-idm-api/docs#/default/root_api_idm__post)


## 사용법

### Docker 사용

```bash
docker run -it --name fitpin-idm -p 80:80 --gpus all ghcr.io/fit-pin/fitpin-vton-backend
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
