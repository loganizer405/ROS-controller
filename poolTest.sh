sleep 10 \
&& ros2 run mavros mav safety arm \
&& ros2 run mavros mav sys mode -c STABILIZE \
&& sleep 30 \
&& ros2 run mavros mav safety disarm
