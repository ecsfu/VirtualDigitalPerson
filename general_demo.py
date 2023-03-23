# -*- coding: utf-8 -*-  
import os
import argparse
from os import listdir
#引入飞桨生态的语音和GAN依赖
# from PaddleTools.TTS import TTSExecutor
from local.synthesize_e2e import main
from PaddleTools.GAN import wav2lip

parser = argparse.ArgumentParser()
parser.add_argument('--human', type=str,default=r'data\action_video\action_vedio.mp4', help='human video')
parser.add_argument('--text', type=str,default='测试数字人视频生成,这段话比较长，还有english', help='text')

if __name__ == '__main__':
    args = parser.parse_args()
    text = args.text
    with open('./real_sentence.txt','w',encoding='utf-8') as f:
        f.write('realwav'+' '+text+'\n')
    # TTS = TTSExecutor('default.yaml') #PaddleSpeech语音合成模块
    # wavfile = TTS.run(text=args.text,output='output.wav') #合成音频
    main()  #生成音频到指定文件夹
    input_wav = './test_e2e/realwav.wav'
    out_dir = './gen_video'
    if not os.path.exists(out_dir):
        os.makedirs(out_dir,exist_ok=True)


    output = os.path.join(out_dir, 'realwav.mp4')
    wavfile = input_wav
    video = wav2lip(args.human,wavfile,output) #将音频合成到唇形视频
    # # os.remove(wavfile) #删除临时的音频文件
    # print('视频生成完毕，输出路径为：{}'.format(args.output))