git pull

# 패키지 설치
source ~/miniconda3/etc/profile.d/conda.sh
conda activate idm
conda env update -f environment.yaml --prune

# 서버 실행
uvicorn Server:server --reload --port 8080 --host 0.0.0.0