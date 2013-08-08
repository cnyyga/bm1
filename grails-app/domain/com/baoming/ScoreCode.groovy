package com.baoming

/**
 * 成绩项代码
 */
class ScoreCode {
    String code // 代码
    String name //名称
    BranchCode branchCode //科类代码
    static constraints = {
        branchCode nullable: true
    }
}
