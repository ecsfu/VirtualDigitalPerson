set -e

speaker=speaker
cut_minute=10
sample_rate=32000
ag=2
min_text=4
max_text=60
use_spleeter=True #降噪

stage=0
stop_stage=7

if [ ${stage} -le 0 ] && [ ${stop_stage} -ge 0 ]; then
    # cut video
    echo $stage
    echo "cut video"
    python tools/cut_source.py --path data/$speaker/input_video/ --min $cut_minute --sr $sample_rate || exit -1
fi

if [ ${use_spleeter} == True ]; then
    export TF_FORCE_GPU_ALLOW_GROWTH=true
    if [ ${stage} -le 1 ] && [ ${stop_stage} -ge 1 ]; then
        # spleeter
        echo "spleeter"
        spleeter separate -o data/$speaker/clean_raw -p spleeter:2stems-16kHz data/$speaker/raw/*.wav || exit -1 #环境人声分离后放在clearn_raw
    fi

    if [ ${stage} -le 2 ] && [ ${stop_stage} -ge 2 ]; then
        # glob spleeter vocals
        echo "glob spleeter vocals"
        python tools/glob_spleeter_vocals.py --path data/$speaker/clean_raw/ || exit -1  #人声移动到在clean_raw2中
        echo "convert clean_raw2 to mono"
        python tools/audio_to_mono.py --path data/$speaker/clean_raw2/ --sr $sample_rate || exit -1 #转单声道
        echo "remove raw"
        rm -rf data/$speaker/raw/ || exit -1 #移除raw
        echo "remove clean_raw"
        rm -rf data/$speaker/clean_raw/ || exit -1 #移除clean_raw
        echo "rename clean_raw2 to raw"
        mv data/$speaker/clean_raw2/ data/$speaker/raw/ || exit -1 #重命名clean_raw2 为 raw
    fi
fi

if [ ${stage} -le 3 ] && [ ${stop_stage} -ge 3 ]; then
    # split
    echo "split"
    python tools/split_audio.py --ag $ag --in_path data/$speaker/raw/ || exit -1
    rm -rf data/$speaker/raw/ || exit -1
    echo "normalize volume"     #归一化到(0,min(normalize,1))
    python tools/change_sr.py --path data/$speaker/split/ --sr $sample_rate --normalize 0.8 || exit -1
fi

if [ ${stage} -le 4 ] && [ ${stop_stage} -ge 4 ]; then
    # asr
    cp -r data/$speaker/split/ data/$speaker/split16000/ || exit -1
    echo "change sample rate to 16000 for asr"
    python tools/change_sr.py --path data/$speaker/split16000/ --sr 16000 || exit -1
    echo "asr"
    python tools/gen_text.py --path data/$speaker/split16000/ || exit -1
    mv data/$speaker/split16000/*.txt data/$speaker/split/ || exit -1 #获得声音文本,并移回split
    rm -rf data/$speaker/split16000/ || exit -1  #删除临时文件夹split16000
fi

if [ ${stage} -le 5 ] && [ ${stop_stage} -ge 5 ]; then
    # clean
    echo "data filter"
    python tools/data_filter.py --path data/$speaker/split/ --min $min_text --max $max_text || exit -1

    echo "glob text"
    python tools/glob_text.py --path data/$speaker/split/ || exit -1

fi

if [ ${stage} -le 6 ] && [ ${stop_stage} -ge 6 ]; then
    echo "revise text"
    python tools/revise_text.py --path data/$speaker/split/
fi

if [ ${stage} -le 7 ] && [ ${stop_stage} -ge 7 ]; then
    # hanzi to pinyin
    echo "hanzi to pinyin"
    python tools/hanzi_to_pinyin.py --path data/$speaker/split/ || exit -1
fi
