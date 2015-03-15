package com.baoming

class PlanUse implements Serializable {

    static short  USE_FLG_STU = 1  //学生
    static  short USE_FLG_MED = 2   //中职
    static  short USE_FLG_PUGAO = 3 //旁听生江苏普高
    static  short USE_FLG_ZHONG = 4 //旁听生江苏中职
    static short USE_FLG_WAI = 5   //旁听生外省

    Short flg = USE_FLG_STU    //eg:1,2,3,4,5
    static belongsTo = [plan:Plan]
    static constraints = {
    }

    static mapping = {
        id composite: ['plan','flg']
        version(false)
    }
}
