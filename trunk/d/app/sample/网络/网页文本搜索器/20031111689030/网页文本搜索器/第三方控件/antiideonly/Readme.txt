AntiIDEOnly

    很多共享性质的VCL控件采用IDE-Only的保护方式，即只能在Delphi IDE已经运行的环境下运行。
如果一个一个地去破解这些控件，不仅难度较大，在很大程度上也是重复工作。AntiIDEOnly就是解决
这个问题的最好方法，只要在工程文件源文件（Project->View Source）的uses段中加上AntiIDEOnly，
就可让你的程序彻底摒弃Delphi IDE。由于控件保护的位置有所不同，对于某些控件，必须将
AntiIDEOnly作为uses段的第一个单元。
    目前，我只用AntiIDEOnly测试过FormContainer，mmtools(1.7)，AdrockBackground，Design
Controls，TBarCode等少数几个控件，欢迎大家测试、使用，如果发现问题，请mail到: 
a.x.e@263.net