# VirtualDigitalPerson
## 1.端到端声音克隆<br />
1）下载预训练模型声音模型fastspeech2_mix_ckpt_1.2.0和声码器模型hifigan_aishell3_ckpt_0.2.0放到pretrained_models文件夹下<br />
https://paddlespeech.bj.bcebos.com/t2s/chinse_english_mixed/models/fastspeech2_mix_ckpt_1.2.0.zip <br />
https://paddlespeech.bj.bcebos.com/Parakeet/released_models/hifigan/hifigan_aishell3_ckpt_0.2.0.zip <br />

2）
* 下载MFA预训练模型到MFA\aligner下<br />
https://paddlespeech.bj.bcebos.com/MFA/ernie_sat/aishell3_model.zip<br />

* 安装MFA<br />
conda config --add channels conda-forge
conda install montreal-forced-aligner

* 启动mfa服务<br />
mfa server start

3）将视频放到data\speaker\input_video文件夹下<br />

4）运行run_preprocess.sh,生成训练数据<br />

5）运行run_mix.sh 进行声音合成，test_sentencecs.txt中为输入文字，合成音频会放在test_e2e文件夹下<br />

参考项目：<br />
https://github.com/PaddlePaddle/PaddleSpeech<br />
https://github.com/jerryuhoo/VTuberTalk

