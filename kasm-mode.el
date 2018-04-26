;;; package --- Summary
;;; Mode for 6502 code, using the Kick Assembler.

;;; Commentary:

;;; Code:
(defvar kasm-mode-hook nil)

;; Auto load
(add-to-list 'auto-mode-alist '("\\.kasm\\'" . kasm-mode))

;; To generate regexp:
(defconst kasm-font-lock-keywords
  (let* (
         (x-legal-opcodes '("adc" "ahx" "and" "asl" "axs"
                            "bcc" "bcs" "beq" "bit" "bmi" "bne" "bpl" "bra" "brk" "bvc" "bvs"
                            "clc" "cld" "cli" "clv" "cmp" "cpx" "cpy"
                            "dec" "dex" "dey" "eor" "inc" "inx" "iny" "isc"
                            "jmp" "jsr"
                            "lda" "ldx" "ldy" "lsr" "nop"
                            "ora"
                            "pha" "php" "pla" "plp"
                            "rol" "ror" "rti" "rts"
                            "sac" "sbc" "sbc2" "sec" "sed" "sei" "sir" "sta" "stx" "sty"
                            "tax" "tay" "tsx" "txa" "txs" "tya"))
         (x-illegal-opcodes '("aac" "aax" "alr" "anc" "anc2" "ane" "arr" "aso" "asr" "atx" "axa"
                              "dcm" "dcp" "dop"
                              "hlt"
                              "ins" "isb" "isc"
                              "jam"
                              "kil"
                              "lae" "lar" "las" "lax" "lse" "lxa"
                              "oal"
                              "rla" "rra"
                              "sax" "sbx" "skb" "sha" "shs" "say" "shx" "shy" "slo" "sre" "sxa" "sya"
                              "tas" "top"
                              "xaa" "xas"))
         (x-types '(".byte" ".by" ".dword" ".dw" ".text" ".te" ".word" ".wo"))
         (x-assembler-builtin '("*" ".align" ".assert" ".asserterror" ".const"
                                ".define" ".disk" ".encoding" ".enum" ".error" ".errorif"
                                ".eval" ".file" ".filemodify" ".filenamespace" ".fill" ".for" ".function"
                                ".if" ".import binary" ".import c64" ".import text" ".label" ".macro"
                                ".memblock" ".modify" ".namespace" ".pc" ".plugin" ".print" ".printnow"
                                ".pseudocommand" ".pseudopc" ".return" ".segment" ".segmentdef"
                                ".struct" ".var" ".while" ".zp"))
         (x-preprocessor '("#define" "#elif" "#else" "#endif" "#if" "#import" "#importif"
                           "#importonce" "#undef"))

         (x-legal-opcodes-regexp (regexp-opt x-legal-opcodes 'words))
         (x-illegal-opcodes-regexp (regexp-opt x-illegal-opcodes 'words))
         (x-types-regexp (regexp-opt x-types 'words))
         (x-builtin-regexp (regexp-opt x-assembler-builtin 'words))
         (x-preprocessor-regexp (regexp-opt x-preprocessor 'words)))
    `(
      (,x-legal-opcodes-regexp . font-lock-keyword-face)
      (,x-illegal-opcodes-regexp . font-lock-keyword-face)
      (,x-types-regexp . font-lock-type-face)
      (,x-builtin-regexp . font-lock-builtin-face)
      (,x-preprocessor-regexp . font-lock-preprocessor-face)

      ;; Labels
      ("^\\(\\(\\sw\\|\\s_\\)+\\)\\>:" . font-lock-function-name-face)

      ;; Constants (Numbers)
      ("\\(?:#\\(?:\\$[[:xdigit:]]+\\|%[0-1]+\\|[[:digit:]]+\\)\\|%[0-1]+\\)" . font-lock-constant-face)))
  "6502 Opcodes.")

(defvar kasm-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?\. "w" st)
    (modify-syntax-entry ?# "w" st)
    (modify-syntax-entry ?\n "> b" st)
    (modify-syntax-entry ?/ ". 124b" st)
    st)
  "Syntax table for kasm-mode.")

(define-derived-mode kasm-mode fundamental-mode "KASM"
  "Major mode for the 6502 Kick Assember."
  :syntax-table kasm-mode-syntax-table
  (setq-local font-lock-defaults '(kasm-font-lock-keywords)))

(provide 'kasm-mode)
;;; kasm-mode.el ends here
