# Training Setups

## Label Configurations

### individual

- mito + mito_membrane + mito_DNA
- er + er_membrane
- golgi + golgi_membrane
- microtubules + microtubules_out
- ribosomes
- nucleus + nucleolus
- NE + NE_membrane + nuclear_pore + nuclear_pore_out
- chromatin + NHChrom + EChrom + NEChrom
- centrosome + distal_app + subdistal_app
- ERES + ERES_membrane
- ECS + PM
- MVB + MVB_membrane + lysosome + lysosome_membrane
- vesicle + vesicle_membrane
- LD + LD_membrane

### combined

- _common_: ECS + PM + mito + mito_membrane + vesicle + vesicle_membrane + MVB + MVB_membrane + er + er_membrane + ERES + microtubules + microtubules_out + nucleus
- _all_: _common_ + mito_DNA + golgi + golgi_membrane + lysosome + lysosome_membrane + LD + LD_membrane + nucleolus + NE + NE_membrane + nuclear_pore + nuclear_pore_out + chromatin + NHChrom + HChrom + EChrom + NEChrom + centrosome + distal_app + subdistal_app + ribosomes

### combined for pretraining

- _blobs_: ECS (1) + nucleus (20,21,22,23,24,25,26,27,28,29,37) + blobs (3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22) + membranes (2,3,6,8,10,12,14,16,18,20,22)

## Resolutions

- 8 to 4
- 4 to 4

## Architectures

all architectues:

- kernel_sizes per level: (3,3,3), (3,3,3)
- loss: balanced
- constant upsample
- translationally equivariant

### 4to4

- _network1A_
  - train input: (216, 216, 216), output: (72, 72, 72) (steps: 3)

  ```
  12                                                       12 * 6
     ↘ 2                                                ↗
       12 * 6                                     12 * 6
              ↘ 3                               ↗
                12 * 6^2              12 * 6^2
                        ↘ 3         ↗
                          12 * 6^3
  ```

- _network2A_
  - train input: (349, 349, 349), output: (137, 137, 137) (step: 5)
  ```
  12                                                       12 * 6
     ↘ 3                                                ↗
       12 * 6                                     12 * 6
              ↘ 3                               ↗
                12 * 6^2              12 * 6^2
                        ↘ 3         ↗
                          12 * 6^3
  ```

- _network3A_
  - 196 92 step: 7

  ```
  12                                                       12 * 6
     ↘ 2                                                ↗
       12 * 6                                     12 * 6
              ↘ 2                               ↗
                12 * 6^2              12 * 6^2
                        ↘ 3         ↗
                          12 * 6^3
  ```

- _network4A_
  - 270 126 6

  ```
  12                                                       12 * 3
     ↘ 2                                                ↗
       12 * 3                                     12 * 3
              ↘ 3                               ↗
                12 * 3^2              12 * 3^2
                        ↘ 3         ↗
                          12 * 3^3
  ```

- _network5A_ same padding
  - 162 162 0 / 144 144 -1

  ```
  12                                                       12 * 6
     ↘ 2                                                ↗
       12 * 6                                     12 * 6
              ↘ 3                               ↗
                12 * 6^2              12 * 6^2
                        ↘ 3         ↗
                          12 * 6^3
  ```

- _network6A_ same padding
  - 162 162 0

  ```
  12                                                       12 * 3
     ↘ 2                                                ↗
       12 * 3                                     12 * 3
              ↘ 3                               ↗
                12 * 3^2              12 * 3^2
                        ↘ 3         ↗
                          12 * 3^3
  ```

### 8to4

- _network1B_
  - train input: (198, 198, 198), output: (104, 104, 104) (step: 2)

  ```
                                                                    12 * 6
                                                                2 ↗
  12                                                      12 * 6
     ↘ 2                                                ↗
       12 * 6                                     12 * 6
              ↘ 3                               ↗
                12 * 6^2              12 * 6^2
                        ↘ 3         ↗
                          12 * 6^3
  ```

- _network2B_
  - train input: (268, 268, 268), output: (108, 108, 108) (step: 2)
  ```
                                                                    12 * 6
                                                                2 ↗
  12                                                      12 * 6
     ↘ 3                                                ↗
       12 * 6                                     12 * 6
              ↘ 3                               ↗
                12 * 6^2              12 * 6^2
                        ↘ 3         ↗
                          12 * 6^3
  ```

- _network3B_ (current)
  - 160 108 4  

  ```
                                                                    12 * 6
                                                                2 ↗
  12                                                      12 * 6
     ↘ 2                                                ↗
       12 * 6                                     12 * 6
              ↘ 2                               ↗
                12 * 6^2              12 * 6^2
                        ↘ 3         ↗
                          12 * 6^3
  ```

- _network4B_ less features
-   - 268 108 2

  ```
                                                                    12 * 3
                                                                2 ↗
  12                                                      12 * 3
     ↘ 2                                                ↗
       12 * 3                                     12 * 3
              ↘ 3                               ↗
                12 * 3^2              12 * 3^2
                        ↘ 3         ↗
                          12 * 3^3
  ```

- _network5B_ same padding
  - 108 216 -3

  ```
                                                                    12 * 6
                                                                2 ↗
  12                                                      12 * 6
     ↘ 2                                                ↗
       12 * 6                                     12 * 6
              ↘ 3                               ↗
                12 * 6^2              12 * 6^2
                        ↘ 3         ↗
                          12 * 6^3
  ```

- _network6B_ same padding

  ```
                                                                    12 * 3
                                                                2 ↗
  12                                                      12 * 3
     ↘ 2                                                ↗
       12 * 3                                     12 * 3
              ↘ 3                               ↗
                12 * 3^2              12 * 3^2
                        ↘ 3         ↗
                          12 * 3^3
  ```

  ## Full list:


- setup01
    - network: 1A (4to4)
    - labels: all


- setup02
    - network: 1B (8to4)
    - labels: all


- setup03
    - network: 1A (4to4)
    - labels: common


- setup04
    - network: 1B (8to4)
    - labels: common


- setup05
    - network: 2A (4to4)
    - labels: all


- setup06
    - network: 2B (8to4)
    - labels: all


- setup07
    - network: 2A (4to4)
    - labels: common


- setup08
    - network: 2B (8to4)
    - labels: common


- setup09
    - network: 3A (4to4)
    - labels: all


- setup10
    - network: 3B (8to4)
    - labels: all


- setup11
    - network: 3A (4to4)
    - labels: common


- setup12
    - network: 3B (8to4)
    - labels: common


- setup13
    - network: 4A (4to4)
    - labels: all


- setup14
    - network: 4B (8to4)
    - labels: all


- setup15
    - network: 4A (4to4)
    - labels: common


- setup16
    - network: 4B (8to4)
    - labels: common


- setup17
    - network: 5A (4to4)
    - labels: all


- setup18
    - network: 5B (8to4)
    - labels: all


- setup19
    - network: 5A (4to4)
    - labels: common


- setup20
    - network: 5B (8to4)
    - labels: common


- setup21
    - network: 6A (4to4)
    - labels: all


- setup22
    - network: 6B (8to4)
    - labels: all


- setup23
    - network: 6A (4to4)
    - labels: common


- setup24
    - network: 6B (8to4)
    - labels: common


- setup25
    - network: 1A (4to4)
    - labels: mito + mito_membrane + mito_DNA


- setup26
    - network: 1B (8to4)
    - labels: mito + mito_membrane + mito_DNA


- setup27
    - network: 1A (4to4)
    - labels: er + er_membrane


- setup28
    - network: 1B (8to4)
    - labels: er + er_membrane


- setup29
    - network: 1A (4to4)
    - labels: golgi + golgi_membrane


- setup30
    - network: 1B (8to4)
    - labels: golgi + golgi_membrane


- setup31
    - network: 1A (4to4)
    - labels: microtubules + microtubules_out


- setup32
    - network: 1B (8to4)
    - labels: microtubules + microtubules_out


- setup33
    - network: 1A (4to4)
    - labels: ribosomes


- setup34
    - network: 1B (8to4)
    - labels: ribosomes


- setup35
    - network: 1A (4to4)
    - labels: nucleus + nucleolus


- setup36
    - network: 1B (8to4)
    - labels: nucleus + nucleolus


- setup37
    - network: 1A (4to4)
    - labels: NE + NE_membrane + nuclear_pore + nuclear_pore_out


- setup38
    - network: 1B (8to4)
    - labels: NE + NE_membrane + nuclear_pore + nuclear_pore_out


- setup39
    - network: 1A (4to4)
    - labels: chromatin + NHChrom + EChrom + NEChrom


- setup40
    - network: 1B (8to4)
    - labels: chromatin + NHChrom + EChrom + NEChrom


- setup41
    - network: 1A (4to4)
    - labels: centrosome + distal_app + subdistal_app


- setup42
    - network: 1B (8to4)
    - labels: centrosome + distal_app + subdistal_app


- setup43
    - network: 1A (4to4)
    - labels: ERES + ERES_membrane


-  setup44
    - network: 1B (8to4)
    - labels: ERES + ERES_membrane


- setup45
    - network: 1A (4to4)
    - labels: ECS + PM


- setup46
    - network: 1B (8to4)
    - labels: ECS + PM


- setup47
    - network: 1A (4to4)
    - labels: MVB + MVB_membrane + lysosome + lysosome_membrane


-  setup48
    - network: 1B (8to4)
    - labels: MVB + MVB_membrane + lysosome + lysosome_membrane


- setup49
    - network: 1A (4to4)
    - labels: vesicle + vesicle_membrane


-  setup50
    - network: 1B (8to4)
    - labels: vesicle + vesicle_membrane


- setup51
    - network: 1A (4to4)
    - labels: LD + LD_membrane


- setup52
    - network: 1B (8to4)
    - labels: LD + LD_membrane


- setup53:
    - network: 1A (4to4) + global balancing
    - labels: _blobs_


- setup54:
    - network: 1B (8to4) + global balancing
    - labels: _blobs_


- setup55:
    - network: 1A (4to4)
    - labels: er + er_membrane with individual balancing


- setup56:
    - network: 1A (4to4)
    - labels: ribosomes
    - prioritized sampling: ribosomes


- setup57:
    - network: 1A (4to4)
    - labels: golgi + golgi_membrane
    - prioritized sampling: golgi


- setup58:
    - network: 1A (4to4)
    - labels: MVB + MVB_membrane + lysosome + lysosome_membrane
    - prioritized sampling: MVB


- setup59:
    - network: 1A (4to4)
    - labels: vesicle + vesicle_membrane
    - prioritized sampling: vesicle


- setup60:
    - network: 1B (8to4)
    - labels: MVB + MVB_membrane + lysosome + lysosome_membrane
    - prioritized sampling: MVB


- setup61:
    - network: 1A (4to4)
    - labels: common
    - crops only from: `/groups/cosem/cosem/data/HeLa_Cell2_4x4x4nm/HeLa_Cell2_4x4x4nm.n5`


- setup62:
    - network: 1A (4to4)
    - labels: common
    - crops only from: `/groups/cosem/cosem/data/Macrophage_FS80_Cell2_4x4x4nm/Cryo_FS80_Cell2_4x4x4nm.n5`


- setup63:
    - network: 1A (4to4)
    - labels: common
    - crops only from: `/groups/cosem/cosem/data/HeLa_Cell3_4x4x4nm/HeLa_Cell3_4x4x4nm.n5`


- setup64:
    - network: 1A (4to4)
    - labels: common
    - crops only from: `/groups/cosem/cosem/data/Jurkat_Cell1_4x4x4nm/Jurkat_Cell1_FS96-Area1_4x4x4nm.n5`


- setup65
    - network: 1A (4to4)
    - labels: ECS + PM
    - prioritized sampling: PM


-  setup66
    - network: 1B (8to4)
    - labels: ECS + PM
    - prioritized sampling: PM


- setup67
    - network: 1A (4to4)
    - labels: MVB + MVB_membrane + lysosome + lysosome_membrane
    - prioritized sampling: lysosome


-  setup68
    - network: 1B (8to4)
    - labels: MVB + MVB_membrane + lysosome + lysosome_membrane
    - prioritized sampling: lysosome


-  setup69
    - network: 1B (8to4)
    - labels: vesicle + vesicle_membrane
    - prioritized sampling: vesicle


- setup70
    - network: 1A (4to4)
    - labels: LD + LD_membrane
    - prioritized sampling: LD


-  setup71
    - network: 1B (8to4)
    - labels: LD + LD_membrane
    - prioritized sampling: LD
 
 
- setup72
    - network: 1A (4to4)
    - labels: microtubules + microtubules_out
    - prioritized sampling: microtubules


- setup73
    - network: 1B (8to4)
    - labels: microtubules + microtubules_out
    - prioritized sampling: microtubules
  

- setup74
    - network: 1B (8o4)
    - labels: ribosomes
    - prioritized sampling: ribosomes


- setup75
    - network: 1A (4to4)
    - labels: nucleus + nucleolus
    - prioritized sampling: nucleus


-  setup76
    - network: 1B (8to4)
    - labels: nucleus + nucleolus
    - prioritized sampling: nucleus


- setup77
    - network: 1A (4to4)
    - labels: nucleus + nucleolus
    - prioritized sampling: nucleolus


-  setup78
    - network: 1B (8to4)
    - labels: nucleus + nucleolus
    - prioritized sampling: nucleolus


- setup79
    - network: 1A (4to4)
    - labels: centrosome + distal_app + subdistal_app
    - prioritized sampling: centrosome


- setup80
    - network: 1A (4to4)
    - labels: mito + mito_membrane + mito_DNA
    - prioritized sampling: mito


- setup81
    - network: 1B (8to4)
    - labels: mito + mito_membrane + mito_DNA
    - prioritized sampling: mito


- setup82
    - network: 1A (4to4)
    - labels: er + er_membrane
    - prioritized sampling: er


-  setup83
    - network: 1B (8to4)
    - labels: er + er_membrane
    - prioritized sampling: er


- setup84
    - network: 1B (8to4)
    - labels: golgi + golgi_membrane
    - prioritized sampling: golgi


- setup85
    - network: 1A (4to4)
    - labels: ERES + ERES_membrane
    - prioritized sampling: ERES


-  setup86
    - network: 1B (8to4)
    - labels: ERES + ERES_membrane
    - prioritized sampling: ERES


- setup87
    - network: 1A (4to4)
    - labels: ECS + PM
    - prioritized sampling: ECS


- setup88
    - network: 1B (8to4)
    - labels: ECS + PM
    - prioritized sampling: ECS

- setup89
    - network: 1A (4to4)
    - labels: NE + NE_membrane + nuclear_pore + nuclear_pore_out
    - prioritized sampling: NE

- setup90
    - network: 1B (8to4)
    - labels: NE + NE_membrane + nuclear_pore + nuclear_pore_out
    - prioritized sampling: NE

- setup91
    - network: 1A (4to4)
    - labels: NE + NE_membrane + nuclear_pore + nuclear_pore_out
    - prioritized sampling: nuclear_pore

- setup92
    - network: 1B (8to4)
    - labels: NE + NE_membrane + nuclear_pore + nuclear_pore_out
    - prioritized sampling: nuclear_pore

- setup93
    - network: 1A (4to4)
    - labels: chromatin + NHChrom + EChrom + NEChrom
    - prioritized sampling: chromatin

- setup94
    - network: 1B (8to4)
    - labels: chromatin + NHChrom + EChrom + NEChrom
    - prioritized sampling: chromatin

- setup95
    - network: 1A (4to4)
    - labels: chromatin + NHChrom + EChrom + NEChrom
    - prioritized sampling: NHChrom

- setup96
    - network: 1B (8to4)
    - labels: chromatin + NHChrom + EChrom + NEChrom
    - prioritized sampling: NHChrom

- setup97
    - network: 1A (4to4)
    - labels: chromatin + NHChrom + EChrom + NEChrom
    - prioritized sampling: EChrom

- setup98
    - network: 1B (8to4)
    - labels: chromatin + NHChrom + EChrom + NEChrom
    - prioritized sampling: EChrom

- setup99
    - network: 1B (8to4)
    - labels: centrosome + distal_app + subdistal_app
    - prioritized sampling: centrosome


