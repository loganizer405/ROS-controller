#arm vehicle
ros2 run mavros mav safety arm
#set to stablize mode (manual = 0, stablilize = 15)
ros2 run mavros mav sys mode -c GUIDED
#make sure workspace is set up then start publisher
. install/setup.bash
ros2 run manual_pubsub talker
