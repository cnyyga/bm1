package com.baoming

class PlanUse implements Serializable {

    static short  USE_FLG_STU = 1  //学生
    static  short USE_FLG_MED = 2   //中职
    static  short USE_FLG_PREPPY = 3 //旁听生

    static  short USE_FLG_PREPPY4 = 4 //中职在校生
    static  short USE_FLG_PREPPY5 = 5 //普通高中在校生
    static  short USE_FLG_PREPPY6 = 6 //中职毕业生未曾被普通高校录取
    static  short USE_FLG_PREPPY7 = 7 //中职毕业生已经被普通高校录取
    static  short USE_FLG_PREPPY8 = 8 //普通高中毕业生未曾被普通高校录取
    static  short USE_FLG_PREPPY9 = 9 //普通高中毕业生已经被普通高校录取
    static  short USE_FLG_PREPPY10 = 10 //曾经在江苏高中或中职读书
    static  short USE_FLG_PREPPY11 = 11 //一直在其他省份高中或中职读书


    Short flg = USE_FLG_STU
    static belongsTo = [plan:Plan]
    static constraints = {
    }

    static mapping = {
        id composite: ['plan','flg']
        version(false)
    }
}
