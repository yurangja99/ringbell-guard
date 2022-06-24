# tensorflow Lite와 Arduino를 이용한 길거리 동물 접근 방지 체계


!echo "const unsigned char model[] = {" > /model.h

!cat gesture_model.tflite | xxd -i      >> /model.h

!echo "};"                              >> /model.h
