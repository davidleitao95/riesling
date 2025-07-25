@test "Denoise" {
    MAT=128
    VOX=1
    ITS=64
    riesling phantom phantom.h5 --matrix=$MAT --vox-size=$VOX --size=56 --gradcubes
    riesling montage -x --comp=m --max=3 --title="Phantom" phantom.h5 phantom.png
    L=0.1
    riesling noisify phantom.h5 phantom-noisy.h5 --std=${L}
    riesling montage -x --comp=m --max=3 --title="Noisy" phantom-noisy.h5 noisy.png
    riesling denoise phantom-noisy.h5 phantom-lap.h5 --lap=${L}  --max-its=${ITS}
    riesling denoise phantom-noisy.h5 phantom-lap2.h5 --lap2=${L}  --max-its=${ITS}
    riesling montage -x --comp=m --max=3 --title="Isotropic Laplacian" phantom-lap2.h5 laplacian.png
    riesling denoise phantom-noisy.h5 phantom-tv.h5 --tv=${L}  --max-its=${ITS}
    riesling montage -x --comp=m --max=3 --title="TV" phantom-tv.h5 tv.png
    riesling denoise phantom-noisy.h5 phantom-tv2.h5 --tv2=${L} --max-its=${ITS}
    riesling denoise phantom-noisy.h5 phantom-tv22.h5 --tv22=${L} --max-its=${ITS}
    riesling montage -x --comp=m --max=3 --title="TV2" phantom-tv22.h5 tv2.png
    riesling denoise phantom-noisy.h5 phantom-tgv.h5 --tgv=${L} --max-its=256
    riesling montage -x --comp=m --max=3 --title="TGV" phantom-tgv.h5 tgv.png
    riesling denoise phantom-noisy.h5 phantom-wav.h5 --wavelets=${L} --max-its=${ITS}
}
