# VirtualDigitalPerson
###1.端到端声音克隆<br />
1）下载预训练模型声音模型fastspeech2_mix_ckpt_1.2.0https://paddlespeech.bj.bcebos.com/t2s/chinse_english_mixed/models/fastspeech2_mix_ckpt_1.2.0.zip和声码器模型hifigan_aishell3_ckpt_0.2.0放到pretrained_models文件夹下<br />
2）将视频放到data\speaker\input_video文件夹下<br />
3）运行run_preprocess.sh,生成训练数据<br />
4）运行run_mix.sh 进行声音合成，test_sencens.txt中为输入文字，合成音频会放在test_e2e文件夹下<br />

