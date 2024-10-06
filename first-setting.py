"""필수 모델 및 Huggingface 모델 다운로드"""
import subprocess
from sys import stdout
import sys

"""모델 다운로드 부분"""
urls = [
    [
        "./ckpt/densepose/",
        "https://huggingface.co/spaces/yisol/IDM-VTON/resolve/main/ckpt/densepose/model_final_162be9.pkl?download=true",
    ],
    [
        "./ckpt/humanparsing/",
        "https://huggingface.co/spaces/yisol/IDM-VTON/resolve/main/ckpt/humanparsing/parsing_atr.onnx?download=true",
    ],
    [
        "./ckpt/humanparsing/",
        "https://huggingface.co/spaces/yisol/IDM-VTON/resolve/main/ckpt/humanparsing/parsing_lip.onnx?download=true",
    ],
    [
        "./ckpt/openpose/ckpts/",
        "https://huggingface.co/spaces/yisol/IDM-VTON/resolve/main/ckpt/openpose/ckpts/body_pose_model.pth?download=true",
    ],
]
"""모델 다운로드 주소 [경로, 주소]"""

process: list[subprocess.Popen] = []

# 명령을 비동기로 실행
for i, url in enumerate(urls):
    process.append(
        subprocess.Popen(
            ["curl", "-OJ", "--location", "--output-dir", url[0], url[1]],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
    )

for i, pr in enumerate(process):
    _, stdout = pr.communicate()

    print({i: stdout})
    if pr.returncode != 0:
        print(f"다운로드 실패: {urls[i][1]}")

print("필수 모델 다운로드 완료")

"""HugFace 모델 로드"""

print("Huggingface 모델 다운로드 진행중")
sys.path.append("./gradio_demo")
from gradio_demo import app
print("Huggingface 모델 다운로드 완료")