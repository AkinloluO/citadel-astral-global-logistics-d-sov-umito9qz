# Executive Problem Framing (SCQA) — Node 1: The Spreadsheet Autopsy & Root-Cause Framing

### Situation
Astral Global operates a regional logistics and distribution network across coastal hubs, conducting quarterly financial reconciliations between regional depot balance sheets and the executive consolidated ledger to verify inventory and capital balances.

### Complication
During Q3 financial sign-off, the reconciliation engine flagged an irreconcilable ₦420M variance between regional depot balance sheets and the executive consolidated ledger. Because it remains unclear whether this discrepancy stems from physical cargo shrinkage at coastal hubs or an administrative collapse from manual Excel consolidation, the Executive Committee halted Q3 sign-off and the Chief Operating Officer froze all regional expansion capital.

### Question
How can we isolate whether the ₦420M variance stems from physical inventory shrinkage or manual spreadsheet consolidation errors, and what technical verification will satisfy executive audit requirements to unfreeze capital?

### Answer (Recommendation)
 Audit raw staging intake logs from Q3_Consolidated_Depots_FINAL_v2.xlsx to isolate physical cargo shrinkage from manual formula overrides, applying the necessary queries using WHERE, DISTINCT, GROUP BY, TRIM clauses to filter out duplicate keys, empty cells and whitespacing.

---
*Evaluated by Citadel Arbiter Rubric | Score: 88/100*
