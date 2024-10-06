rm -rf ./ckpt/densepose/* ./ckpt/humanparsing/* ./ckpt/openpose/ckpts/*

curl -OJ --location --output-dir ./ckpt/densepose/  https://huggingface.co/spaces/yisol/IDM-VTON/resolve/main/ckpt/densepose/model_final_162be9.pkl?download=true
curl -OJ --location --output-dir ./ckpt/humanparsing/  https://huggingface.co/spaces/yisol/IDM-VTON/resolve/main/ckpt/humanparsing/parsing_atr.onnx?download=true
curl -OJ --location --output-dir ./ckpt/humanparsing/ https://huggingface.co/spaces/yisol/IDM-VTON/resolve/main/ckpt/humanparsing/parsing_lip.onnx?download=true
curl -OJ --location --output-dir ./ckpt/openpose/ckpts/ https://huggingface.co/spaces/yisol/IDM-VTON/resolve/main/ckpt/openpose/ckpts/body_pose_model.pth?download=true