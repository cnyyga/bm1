package com.baoming

class PlanUse implements Serializable {

    static short  USE_FLG_STU = 1  //学生
    static  short USE_FLG_MED = 2   //中职
    static  short USE_FLG_PREPPY = 3 //旁听生

    Short flg = USE_FLG_STU
    static belongsTo = [plan:Plan]
    static constraints = {
    }

    static mapping = {
        id composite: ['plan','flg']
        version(false)
    }
}
