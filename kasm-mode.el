;;; package --- Summary
;;; Mode for 6502 code, using the Kick Assembler.

;;; Commentary:

;;; Code:
(defvar kasm-mode-hook nil)

;; Auto load
(add-to-list 'auto-mode-alist '("\\.kasm\\'" . kasm-mode))

;; To generate regexp:

;; (regexp-opt '("adc" "ahx" "alr" "anc" "anc2" "and" "asl" "axs"
;;               "bcc" "bcs" "beq" "bit" "bmi" "bne" "bpl" "bra" "brk" "bvc" "bvs"
;;                "clc" "cld" "cli" "clv" "cmp" "cpx" "cpy"
;;                "dcp" "dec" "dex" "dey" "eor" "inc" "inx" "iny" "isc"
;;                "jmp" "jsr"
;;                "las" "lax" "lda" "ldx" "ldy" "lsr" "nop"
;;                "ora"
;;                "pha" "php" "pla" "plp"
;;                "rla" "rol" "ror" "rra" "rti" "rts"
;;                "sac" "sax" "sbc" "sbc2" "sec" "sed" "sei" "shx" "shy" "sir" "slo" "sre" "sta" "stx" "sty"
;;                "tas" "tax" "tay" "tsx" "txa" "txs" "tya" "xaa"))

;; (regexp-opt '("*" ".align" ".assert" ".asserterror" ".by" ".byte" ".const"
;;               ".define" ".disk" ".dw" ".dword" ".encoding" ".enum" ".error" ".errorif"
;;               ".eval" ".file" ".filemodify" ".filenamespace" ".fill" ".for" ".function"
;;               ".if" ".import binary" ".import c64" ".import text" ".label" ".macro"
;;               ".memblock" ".modify" ".namespace" ".pc" ".plugin" ".print" ".printnow"
;;               ".pseudocommand" ".pseudopc" ".return" ".segment" ".segmentdef"
;;               ".struct" ".te" ".text" ".var" ".while" ".wo" ".word" ".zp"))

;; (regexp-opt '("#define" "#elif" "#else" "#endif" "#if" "#import" "#importif"
;;               "#importonce" "#undef"))

(defconst kasm-font-lock-keywords
  '(
    ;; 6502 Opcodes
    ("\\b\\(?:a\\(?:dc\\|hx\\|lr\\|n\\(?:c2\\|[cd]\\)\\|sl\\|xs\\)\\|b\\(?:c[cs]\\|eq\\|it\\|mi\\|ne\\|pl\\|r[ak]\\|v[cs]\\)\\|c\\(?:l[cdiv]\\|mp\\|p[xy]\\)\\|d\\(?:cp\\|e[cxy]\\)\\|eor\\|i\\(?:n[cxy]\\|sc\\)\\|j\\(?:mp\\|sr\\)\\|l\\(?:a[sx]\\|d[axy]\\|sr\\)\\|nop\\|ora\\|p\\(?:h[ap]\\|l[ap]\\)\\|r\\(?:la\\|o[lr]\\|ra\\|t[is]\\)\\|s\\(?:a[cx]\\|bc2?\\|e[cdi]\\|h[xy]\\|ir\\|lo\\|re\\|t[axy]\\)\\|t\\(?:a[sxy]\\|sx\\|x[as]\\|ya\\)\\|xaa\\)\\b" . font-lock-keyword-face)

    ;; Kick Assembler builtin
    ("\\(?:\\*\\|\\.\\(?:a\\(?:lign\\|ssert\\(?:error\\)?\\)\\|by\\(?:te\\)?\\|const\\|d\\(?:efine\\|isk\\|w\\(?:ord\\)?\\)\\|e\\(?:n\\(?:coding\\|um\\)\\|rror\\(?:if\\)?\\|val\\)\\|f\\(?:il\\(?:e\\(?:modify\\|namespace\\)\\|[el]\\)\\|or\\|unction\\)\\|i\\(?:f\\|mport \\(?:binary\\|c64\\|text\\)\\)\\|label\\|m\\(?:acro\\|emblock\\|odify\\)\\|namespace\\|p\\(?:c\\|lugin\\|rint\\(?:now\\)?\\|seudo\\(?:command\\|pc\\)\\)\\|return\\|s\\(?:egment\\(?:def\\)?\\|truct\\)\\|te\\(?:xt\\)?\\|var\\|w\\(?:hile\\|o\\(?:rd\\)?\\)\\|zp\\)\\)" . font-lock-builtin-face)

    ;; Pre-processor
    ("^\\(?:#\\(?:define\\|e\\(?:l\\(?:if\\|se\\)\\|ndif\\)\\|i\\(?:f\\|mport\\(?:if\\|once\\)?\\)\\|undef\\)\\)\\b" . font-lock-preprocessor-face)
    ;; Labels
    ("^\\(\\(\\sw\\|\\s_\\)+\\)\\>:" . font-lock-function-name-face)

    ;; Constants (Numbers)
    ("\\(?:#\\(?:\\$[[:xdigit:]]+\\|%[0-1]+\\|[[:digit:]]+\\)\\|%[0-1]+\\)" . font-lock-constant-face)
   )
  "6502 Opcodes.")

(defvar kasm-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?\n "> b" st)
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?* ". 23" st)
    st)
  "Syntax table for kasm-mode.")

(define-derived-mode kasm-mode fundamental-mode "KASM"
  "Major mode for the 6502 Kick Assember."
  :syntax-table kasm-mode-syntax-table
  (setq-local font-lock-defaults '(kasm-font-lock-keywords)))

(provide 'kasm-mode)
;;; kasm-mode.el ends here
