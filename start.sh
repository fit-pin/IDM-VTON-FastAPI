git pull

# 패키지 설치
source ~/miniconda3/etc/profile.d/conda.sh
conda activate idm
conda env update -f environment.yaml --prune

# 최초 실행 여부 판단
# 이게 dockerfile 빌드할때 gpu 사용이 불가해서 first-setting.py가 실행을 못하더라
if ! [ -f  ./.initfile ]; then
    python first-setting.py
fi

# 서버 실행
uvicorn Server:server --reload --port 80 --host 0.0.0.0 --log-config ./log-config.yml