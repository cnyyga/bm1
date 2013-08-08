package com.baoming
import com.baoming.account.Student
//考生体检信息
class PhysicalExamination {
    String code //体检序号
    String anamnesisTag //既往病史标志(1-无，0-有)
    String anamnesis //既往病史

    static belongsTo = [student:Student]

    static constraints = {
    }
}

//眼科
class Ophthalmology {
    String nakedVisionRight //眼科.裸眼视力(右)
    String nakedVisionLeft //眼科.裸眼视力(左)
    String correctedVisionRight //眼科.矫正视力(右)
    String correctedVisionLeft //眼科.矫正视力(左)
    String correctedDegreeRight //矫正度数(右)
    String correctedDegreeLeft//矫正度数(左)
    String colorDigital  //彩色图案及数码检查(1-正常,2-其他)
    String colorVisionPlate //色觉检查图名称(1-喻自萍,2-其他)
    String monochromaticRed // 单色识别能力（红）（1-能识别，0-不能识别）
    String monochromaticYellow // 单色识别能力（黄）（1-能识别，0-不能识别）
    String monochromaticGreen // 单色识别能力（绿）（1-能识别，0-不能识别）
    String monochromaticBlue // 单色识别能力（蓝）（1-能识别，0-不能识别）
    String monochromaticPurple// 单色识别能力（紫））（1-能识别，0-不能识别）
    String physician  // 眼科医师意见(1-合格，2-专业受限，3-不合格）
    String description //眼病（具体描述）


}

//内科
class Medical {
    String systolicPressure  //血压收缩压（高压）(单位:kpa)
}

//外科
class Surgery {
    Integer stature //身高(单位:厘米)
}

//耳鼻喉科
class Otolaryngological{
    Integer auditionLeft //左耳听力(单位:米)
}

//口腔科
class Stomatology {
     String palate //.唇腭(1-正常,2-其他)
}

