FROM nvcr.io/nvidia/l4t-base:r34.1.1

# change the locale from POSIX to UTF-8
RUN apt-get update && apt-get install -y --no-install-recommends locales software-properties-common \
&& locale-gen en_US en_US.UTF-8 \
&& update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
&& export LANG=en_US.UTF-8 \
&& add-apt-repository universe

# add ROS deb repo to apt sources list
RUN apt-get update && apt-get install -y --no-install-recommends \
	curl \
	gnupg2 \
	lsb-release
RUN apt-get update \
&& curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  git \
  libbullet-dev \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-pytest-cov \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget \
# install some pip packages needed for testing
&& python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
# install Fast-RTPS dependencies
&& apt-get install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev \
# install Cyclone DDS dependencies
&& apt-get install --no-install-recommends -y \
  libcunit1-dev


RUN mkdir -p /home/ros2_foxy/src
WORKDIR /home/ros2_foxy
RUN wget https://raw.githubusercontent.com/ros2/ros2/foxy/ros2.repos \
&& vcs import src < ros2.repos
    
RUN apt-get update \
&& rosdep init \
&& rosdep update \
&& rosdep install -y --from-paths src --ignore-src --skip-keys "fastcdr rti-connext-dds-5.3.1 urdfdom_headers" \
# do these at the end to clean apt stuff
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN colcon build --symlink-install
WORKDIR /

#RUN . /home/ros2_foxy/install/local_setup.bash
#RUN echo ". /home/ros2_foxy/install/local_setup.bash" >> /root/.bashrc
#
#RUN mkdir -p /home/controller/src
#WORKDIR /home/controller/src
#RUN ros2 pkg create--build-type ament_cmake --node-name controller_node robosub --dependencies rclcpp mavros std_msgs sensor_msgs
#
#RUN rosdep install -i --from-path src --rosdistro foxy -y \
	#&& colcon build --packages-select robosub
	#&& colcon build \
	#&& . install/local_setup.bash
