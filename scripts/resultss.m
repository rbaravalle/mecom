A = [1.7211    1.8001    1.3657    0.9718    0.7907    0.7409    0.6525    0.6353    0.6529    0.5627
    1.8126    1.7978    1.2677    0.9897    0.8194    0.7197    0.6586    0.6177    0.5292    0.5331
    1.8022    1.5274    1.4110    1.2110    0.9950    0.8261    0.7018    0.6280    0.5371    0.5365
    1.7158    1.6826    1.3399    1.1105    0.9030    0.7482    0.6404    0.5645    0.5159    0.5019
    1.7795    1.7661    1.3598    1.0828    0.8954    0.7587    0.6521    0.5941    0.5621    0.4746
    1.7722    1.4598    1.3310    1.2368    1.0693    0.8925    0.7410    0.6595    0.5803    0.5135
    1.7664    1.7610    1.3833    1.0392    0.8338    0.6870    0.6045    0.5303    0.4902    0.4503
    1.7989    1.7947    1.2926    1.0148    0.8595    0.7538    0.6896    0.5726    0.5752    0.5186
    1.7646    1.5815    1.3499    1.2015    1.0046    0.8098    0.7001    0.5984    0.5194    0.4845
    1.7738    1.7795    1.4286    0.9717    0.7467    0.6652    0.5564    0.4950    0.5783    0.3739
    1.8035    1.8212    1.2781    0.9839    0.8348    0.7134    0.6377    0.5968    0.5419    0.5675
    1.8307    1.4837    1.2759    1.1958    1.0546    0.9041    0.7835    0.6840    0.6064    0.5283
    1.7690    1.7798    1.4180    1.0016    0.7720    0.7136    0.6055    0.6274    0.5847    0.5679
    1.7976    1.7515    1.3556    1.0263    0.8431    0.7222    0.6561    0.5995    0.5672    0.5130
    1.8190    1.5810    1.3848    1.1888    0.9880    0.8272    0.6866    0.6018    0.5543    0.4793
]

B = [   0.5644    0.6012    0.5685    0.5186    0.3705    0.6014    0.5421    0.3711    0.4881    0.2224
    0.5498    0.5178    0.4803    0.3890    0.6134    0.4708    0.6103    0.4860    0.6214    0.1552
    0.4737    0.4338    0.3457    0.3711    0.2924    0.2381    0.2477    0.4617    0.1386    0.3012
    0.4641    0.4857    0.4271    0.4187    0.3961    0.3367    0.3842    0.2797    0.4227    0.2708
    0.4373    0.4813    0.3752    0.4238    0.2565    0.2136    0.0905    0.3301    0.1517   -0.0603
    0.4735    0.4397    0.3495    0.3748    0.3923    0.2818    0.2737    0.2436    0.1690   -0.1095
    0.4592    0.3438    0.3187    0.2534   -0.1095    0.1061    0.2651    0.3403    0.5004         0
    0.4935    0.4674    0.5184    0.4918    0.4582    0.5500    0.2974    0.4049    0.2780    0.0040
    0.4225    0.4456    0.4010    0.2774    0.4029    0.4416    0.1791   -0.1412    0.3523         0
    0.4572    0.4410    0.5375    0.0119    0.2211    0.3312    0.3196    0.3370    0.3655    0.0931
    0.5935    0.5791    0.4787    0.4825    0.6313    0.4628    0.3586         0         0         0
    0.5000    0.4390    0.3811    0.4071    0.3702    0.3460    0.1302    0.3264    0.4175   -0.1412
    0.5611    0.5449    0.5613    0.6266    0.5692    0.5642    0.6070    0.6080    0.4762    0.4111
    0.4482    0.4835    0.4709    0.4356    0.5107    0.3762    0.4019    0.4166    0.1105    0.1013
    0.4984    0.4659    0.3970    0.4763    0.3977    0.3465    0.3159    0.1791    0.1822    0.0712]

C = [         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0]

results = [A B C]

A = [  1.7180    1.7351    1.3956    1.0527    0.7993    0.6946    0.6087    0.5712    0.6070    0.5062
    1.8141    1.7830    1.2594    0.9723    0.8134    0.7077    0.6379    0.5708    0.5517    0.5418
    1.7840    1.5182    1.3035    1.2069    1.0400    0.8756    0.7372    0.6394    0.5588    0.5304
    1.7840    1.8290    1.3319    0.9373    0.7449    0.6376    0.5793    0.5334    0.5208    0.3392
    1.7610    1.7000    1.4092    1.0844    0.8732    0.7476    0.6743    0.6370    0.5771    0.5375
    1.8199    1.5124    1.4107    1.2176    1.0018    0.8281    0.7183    0.6565    0.5782    0.5123
    1.7585    1.8728    1.2397    0.8609    0.7259    0.6841    0.5945    0.5217    0.3715    0.3874
    1.7770    1.7862    1.3636    1.0036    0.8155    0.6935    0.6586    0.5797    0.5347    0.5488
    1.8236    1.5577    1.3715    1.1974    0.9946    0.8364    0.7400    0.6426    0.5957    0.5328
    1.7577    1.8403    1.3036    0.8998    0.7254    0.7237    0.6086    0.6667    0.5978    0.4811
    1.8275    1.8054    1.2569    0.9806    0.8098    0.7166    0.6545    0.6314    0.5606    0.5745
    1.7793    1.5509    1.2587    1.1475    1.0178    0.8835    0.7595    0.6663    0.5855    0.5355
    1.7708    1.7475    1.4479    1.0105    0.7853    0.6546    0.6260    0.5197    0.5575    0.5837
    1.7951    1.7952    1.2855    1.0008    0.8394    0.7234    0.6547    0.6130    0.5587    0.5254
    1.8022    1.6503    1.4319    1.1461    0.9118    0.7666    0.6478    0.5856    0.5572    0.5418
]

B = [
   0.4885    0.4006    0.3851    0.6001    0.4174    0.4304    0.2001    0.4008    0.3523    0.3403
    0.5233    0.5119    0.5455    0.5666    0.5840    0.4522    0.4495    0.3241    0.3611    0.3497
    0.4635    0.4689    0.4114    0.4115    0.2870    0.2889    0.1880    0.4089    0.3432    0.2230
    0.4703    0.4413    0.5588    0.3077    0.4306    0.5017    0.4667    0.3073    0.3013    0.2737
    0.4882    0.4444    0.4397    0.4679    0.4670    0.3908    0.1673    0.3098    0.0489         0
    0.5080    0.4712    0.4690    0.4486    0.4454    0.5123    0.4305    0.4365    0.2510    0.5084
    0.3203    0.4739    0.5553    0.6229    0.5310    0.4900    0.4275    0.2382    0.5296         0
    0.5635    0.5397    0.6106    0.5264    0.5660    0.3441    0.3487    0.2275    0.4407    0.1462
    0.5186    0.4419    0.4561    0.3650    0.4232    0.2718    0.3193    0.0648    0.2339         0
    0.5652    0.5580    0.4745    0.6503    0.6376    0.6041    0.5374    0.2252    0.4008         0
    0.5879    0.5552    0.5065    0.4529    0.4938    0.3461    0.3719    0.3357    0.2256    0.5917
    0.4643    0.4318    0.3855    0.2957    0.3309    0.2058    0.2594    0.2993    0.1146    0.1462
    0.5748    0.6721    0.5602    0.5406    0.3590    0.6649    0.5186    0.4608    0.3183    0.1601
    0.5632    0.5106    0.4106    0.3814    0.2737    0.3571    0.4017    0.4586    0.5353         0
    0.4264    0.3552    0.3602    0.6250   -0.1086    0.0650    0.1016    0.0000    0.1601   -0.3403
]


C = [
    0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0]

results = [results; [A B C]]

A = [
  1.7854    1.7135    1.4338    1.0533    0.8371    0.7106    0.6761    0.6045    0.5464    0.4850
    1.8208    1.8188    1.2895    0.9857    0.8213    0.7316    0.6815    0.6073    0.6066    0.6037
    1.8312    1.3878    1.3515    1.2508    1.0758    0.9071    0.7862    0.6834    0.6160    0.5716
]

B = [
  0.5443    0.4643    0.4716    0.5534    0.5529    0.4809    0.5019    0.3852    0.2764    0.4208
    0.5175    0.4445    0.4523    0.3959    0.2921    0.2422    0.3966    0.2926    0.4225         0
    0.5401    0.4970    0.4780    0.4466    0.3970    0.3936    0.3398    0.4694    0.3972    0.2941]

C = [         0
         0
         0]

results = [results; [A B C]]

A = [   1.7854    1.7135    1.4338    1.0533    0.8371    0.7106    0.6761    0.6045    0.5464    0.4850
    1.8208    1.8188    1.2895    0.9857    0.8213    0.7316    0.6815    0.6073    0.6066    0.6037
    1.8312    1.3878    1.3515    1.2508    1.0758    0.9071    0.7862    0.6834    0.6160    0.5716
    1.7609    1.8570    1.2292    0.8920    0.7283    0.6027    0.5850    0.5343    0.6160    0.5916
    1.7890    1.7677    1.3374    1.0147    0.8339    0.7154    0.6869    0.6447    0.6394    0.5465
    1.7824    1.6154    1.4110    1.1885    0.9423    0.7714    0.6690    0.5770    0.5344    0.4378
    1.7151    1.8551    1.3014    0.8759    0.7644    0.7176    0.7207    0.6538    0.6393    0.6312
    1.7777    1.8036    1.3186    0.9892    0.8255    0.7526    0.6815    0.6829    0.5920    0.6257
    1.8026    1.5775    1.4846    1.2048    0.9296    0.7604    0.6673    0.5969    0.5065    0.5132
    1.7771    1.7753    1.3059    1.0060    0.8185    0.6812    0.6111    0.5322    0.5218    0.5230
    1.8174    1.8291    1.2301    0.9794    0.8158    0.7131    0.6353    0.6294    0.5763    0.5446
    1.7836    1.5449    1.4669    1.2217    0.9619    0.7834    0.6767    0.5933    0.5370    0.5004]

B = [ 0.5443    0.4643    0.4716    0.5534    0.5529    0.4809    0.5019    0.3852    0.2764    0.4208
    0.5175    0.4445    0.4523    0.3959    0.2921    0.2422    0.3966    0.2926    0.4225         0
    0.5401    0.4970    0.4780    0.4466    0.3970    0.3936    0.3398    0.4694    0.3972    0.2941
    0.6375    0.6503    0.5805    0.6071    0.3747    0.5426    0.6085    0.4476    0.5152    0.2149
    0.5072    0.5407    0.4507    0.5053    0.4404    0.4057    0.4287    0.5730    0.4902    0.0801
    0.4369    0.4021    0.2681    0.3551    0.4266    0.3604    0.1114    0.5124    0.0000         0
    0.6229    0.6211    0.6169    0.5592    0.5432    0.9485    0.6574    0.3375         0         0
    0.5615    0.5552    0.4986    0.5644    0.4818    0.5463    0.2671    0.2307    0.2968    0.2737
    0.4789    0.4545    0.4688    0.2089    0.4183    0.0712    0.3303         0    0.5462    0.4406
    0.5199    0.5250    0.4484    0.4008    0.4590    0.4775    0.3635    0.3529    0.5213    0.1504
    0.5533    0.4659    0.4970    0.4602    0.5524    0.4984    0.4364    0.3808    0.6171    0.2737
    0.4379    0.4137    0.3852    0.3338    0.4255    0.4509    0.1744    0.2654    0.1521    0.5124]

C = [
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
         0
]

results = [results; [A B C]]

A = [1.6380    1.8901    1.1930    0.9412    0.8124    0.6773    0.7073    0.5806    0.4853    0.5064
    1.8234    1.7512    1.3562    1.0456    0.8769    0.7365    0.6712    0.6439    0.6273    0.5598
    1.7026    1.4360    1.4208    1.2845    1.0789    0.8898    0.7386    0.6436    0.5677    0.4937
    1.7444    1.8172    1.3000    0.9517    0.7385    0.6463    0.6103    0.5868    0.6016    0.5603
    1.7630    1.8198    1.2807    0.9724    0.8242    0.7600    0.6766    0.5590    0.5823    0.5575
    1.7085    1.4975    1.4570    1.2718    1.0245    0.8234    0.6946    0.5697    0.5070    0.4386
    1.7804    1.8262    1.2699    0.9479    0.7509    0.6411    0.5252    0.5337    0.5519    0.5440
    1.7639    1.7597    1.3631    1.0440    0.8607    0.7517    0.7062    0.6555    0.5902    0.6095
    1.7513    1.5123    1.4566    1.2287    0.9877    0.8210    0.7068    0.6117    0.5361    0.4968]

B = [ 0.5528    0.5958    0.5054    0.7079    0.6515    0.6874    0.4119    0.2991    0.2623    0.1616
    0.5579    0.4702    0.4616    0.4039    0.4790    0.5544    0.3253    0.2050         0         0
    0.4555    0.3991    0.3902    0.2802    0.3518    0.2746    0.2764    0.3230    0.2410    0.4027
    0.5774    0.7286    0.6149    0.2910    0.2461    0.3489    0.5039   -0.0227    0.1995    0.0000
    0.4843    0.5520    0.5439    0.4077    0.7113    0.5952    0.5929    0.3507    0.2446    0.0752
    0.3819    0.3908    0.4030    0.3097    0.1598    0.0564    0.2064   -0.0276   -0.3403         0
    0.4571    0.4110    0.4405    0.7386    0.6918    0.5620    0.2532    0.5158    0.4428    0.6693
    0.5243    0.5394    0.4868    0.4653    0.3807    0.3652    0.3809    0.2854    0.2708    0.2359
    0.4544    0.4426    0.4418    0.3051    0.2710    0.2404    0.3448    0.2145    0.3427         0]

C = [  0
         0
         0
         0
         0
         0
         0
         0
         0]

results = [results; [A B C]]

