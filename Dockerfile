# ubuntu 베이스 이미지 사용
FROM da864268/my-ubuntu:22.04

LABEL maintainer="da864268@naver.com"
LABEL description="fitpin-IDM"

# bash 로 변경
SHELL ["/bin/bash", "-c"]

# 패키지 설치 
RUN apt update && apt upgrade -y && apt install \
libgl1 libglib2.0-0 -y

# CUDA ToolKit 설치
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb && \
dpkg -i cuda-keyring_1.0-1_all.deb && \
apt-get update && \
apt-get install cuda-toolkit-11.8 -y && \
rm -rf cuda-keyring_1.0-1_all.deb

# CUDA Toolkit 환경변수 설정
ENV PATH "/usr/local/cuda/bin:$PATH"
ENV LD_LIBRARY_PATH "/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# USER_NAME 변수 선언
ARG USER_NAME=fitpin

# fitpin 계정 생성
RUN userdel -rf ubuntu; \
adduser --disabled-password ${USER_NAME}

# fitpin 으로 전환
USER ${USER_NAME}
WORKDIR "/home/${USER_NAME}"

#Conda 설치
RUN mkdir -p ~/miniconda3 && \
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -i).sh -O ~/miniconda3/miniconda.sh && \
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 && \
rm -rf ~/miniconda3/miniconda.sh
ENV PATH "/home/${USER_NAME}/miniconda3/bin:$PATH"
RUN conda init && source ~/.bashrc

# IDM-VTON clone
RUN git clone https://github.com/fit-pin/IDM-VTON-FastAPI.git
WORKDIR "/home/${USER_NAME}/IDM-VTON-FastAPI"

# conda 가상환경 만들고 활성화
RUN conda env create -f environment.yaml && \
source ~/miniconda3/etc/profile.d/conda.sh && \
conda activate idm

# 컨테이너 시작시 start.sh 파일 실행
CMD ["/bin/bash", "start.sh"]