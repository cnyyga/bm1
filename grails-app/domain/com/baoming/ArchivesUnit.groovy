package com.baoming

/**
 * 投档单位表
 */
class ArchivesUnit {

    Batch batch //批次代码
    BranchCode branchCode //科类代码
    PlanType planType //计划性质
    String code // 代码
    String name //名称
    String formwork

    static constraints = {
    }
}
