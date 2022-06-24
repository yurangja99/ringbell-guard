# tensorflow Lite와 Arduino를 이용한 길거리 동물 접근 방지 체계

- Kookmin Univ. 이상헌 교수님 수업 자료 이용하여 Classification 

!echo "const unsigned char model[] = {" > /model.h
!cat gesture_model.tflite | xxd -i      >> /model.h
!echo "};"                              >> /model.h
