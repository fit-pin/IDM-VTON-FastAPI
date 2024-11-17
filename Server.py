import io
import sys

# 경로 문제 해결
sys.path.append("./gradio_demo")

import logging
import PIL
import PIL.Image
from fastapi import FastAPI, Form, HTTPException, Request, Response, UploadFile

from gradio_demo import app
from typing import Literal

logger = logging.getLogger("uvicorn.error")
server = FastAPI(
    redoc_url=None, root_path="/ar-idm-api", on_startup=(lambda: (logger.info("서버가 정삭적으로 실행함")),)
)


@server.post("/api/idm/")
def root(
    req: Request,
    humanImg: UploadFile,
    clothesImg: UploadFile,
    category: Literal["상의", "하의", "드레스"] = Form(),
    is_checked: bool = Form(True),
    is_checked_crop: bool = Form(True),
    denoise_steps: int = Form(30),
    seed: int = Form(42),
):
    logger.info(f"{req.client.host}:{req.client.port} - 가상피팅 진행중")  # type: ignore

    background = PIL.Image.open(humanImg.file)
    garm_img = PIL.Image.open(clothesImg.file)

    try:
        result, _ = app.start_tryon(
            dict={"background": background, "layers": None, "composite": None},
            garm_img=garm_img,
            category=category,
            is_checked=is_checked,
            is_checked_crop=is_checked_crop,
            denoise_steps=denoise_steps,
            seed=seed,
        )

        # 이미지를 바이트 형테로 저장
        buffer = io.BytesIO()
        result.save(buffer, format="jpeg")

        logger.info(f"{req.client.host}:{req.client.port} - 가상피팅 완료")  # type: ignore
        return Response(buffer.getvalue(), media_type="image/png")
    except Exception as e:
        logger.error(f"{req.client.host}:{req.client.port} - 애러: {e}")  # type: ignore
        raise HTTPException(status_code=500, detail=f"{e}")
