ROM is 16384 bytes, 2 8k-pages, mapper 0
;Mappings:
; Page 4: 0
; Page 5: 2000
; Page 6: 0
; Page 7: 2000
;Vectors:
; NMI:   C066
; Reset: C000
; IRQ:   C0D2
; Discovered a data table at 2E66,2E70 (stepping 1, extent 10)
; Discovered a data table at 2E66,2E70 (stepping 1, extent 10)
; Discovered a data table at 2E66,2E70 (stepping 1, extent 10)
; Discovered a data table at 2CC8,2CD2 (stepping 1, extent 10)
; Discovered a data table at 2CC8,2CD2 (stepping 1, extent 10)
; Discovered a data table at 2CC8,2CD2 (stepping 1, extent 10)
; Discovered a data table at 2CC8,2CD2 (stepping 1, extent 10)
; UNRESOLVED direct JSR at romprt: $3F70 to $0600!
; UNRESOLVED direct JSR at romprt: $3F7C to $0600!
; UNRESOLVED direct JSR at romprt: $3F7F to $0600!
; UNRESOLVED direct JSR at romprt: $3F8B to $0600!
; UNRESOLVED direct JSR at romprt: $3F8E to $0600!
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1A13,1A1D (stepping 1, extent 10)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 1D14,1D84 (stepping 1, extent 112)
; Discovered a data table at 3296,329E (stepping 1, extent 8)
; Discovered a data table at 1D17,1D87 (stepping 1, extent 112)
; Discovered a data table at 1D17,1D87 (stepping 1, extent 112)
; Discovered a data table at 1D17,1D87 (stepping 1, extent 112)
; Discovered a data table at 1D17,1D87 (stepping 1, extent 112)
_Reset	$C000  AD 02 20:    lda PPUSTATUS
	$C003  10 FB:       bpl _Reset
	$C005  78:          sei 		; ignore IRQs
	$C006  D8:          cld 		; disable decimal mode
	$C007  A2 FF:       ldx #$FF
	$C009  9A:          txs 		; set Stack Pointer at $1FF
	$C00A  A9 00:       lda #$00
	$C00C  A2 14:       ldx #$14
_init_[14:FF]
	$C00E  95 00:       sta $00,x
	$C010  E8:          inx 
	$C011  D0 FB:       bne _init_[14:FF]
	$C013  8D 01 20:    sta PPUMASK
	$C016  A9 1E:       lda #$1E
	$C018  85 15:       sta ppumask_state
	$C01A  A9 90:       lda #$90
	$C01C  8D 00 20:    sta PPUCTRL
	$C01F  85 14:       sta ppuctrl_state
	$C021  A2 0F:       ldx #$0F
-	$C023  BD 00 06:    lda $0600,x
	$C026  DD 9B FF:    cmp _data_3F9B_indexed,x
	$C029  D0 05:       bne _clear[00:13]_init
	$C02B  CA:          dex 
	$C02C  10 F5:       bpl -		; $C023
	$C02E  30 11:       bmi _loc_0041
_clear[00:13]_init
	$C030  A2 13:       ldx #$13
	$C032  A9 00:       lda #$00
_clear[00:13]_loop
	$C034  95 00:       sta $00,x
	$C036  CA:          dex 
	$C037  10 FB:       bpl _clear[00:13]_loop
_setHighScore
	$C039  A9 01:       lda #$01
	$C03B  85 03:       sta $03
	$C03D  85 08:       sta $08
	$C03F  85 0D:       sta $0D
_loc_0041
	$C041  20 6E F4:    jsr _soundPrepare
_inject_code_to_[600:65E]
	$C044  A2 5E:       ldx #$5E
_inject_code_loop
	$C046  BD 9B FF:    lda _data_3F9B_indexed,x
	$C049  9D 00 06:    sta $0600,x
	$C04C  CA:          dex 
	$C04D  10 F7:       bpl _inject_code_loop
	$C04F  A2 07:       ldx #$07
	$C051  A0 00:       ldy #$00
-	$C053  8A:          txa 
	$C054  99 00 01:    sta $0100,y
	$C057  C8:          iny 
	$C058  F0 09:       beq +		; $C063 -> _main_reset_code
	$C05A  98:          tya 
	$C05B  DD FE FC:    cmp _data_3CFE_indexed,x
	$C05E  90 F3:       bcc -		; $C053
	$C060  CA:          dex 
	$C061  10 F0:       bpl -		; $C053
+	$C063  4C 0A E6:    jmp _main_reset_code
;------------------------------------------
_NMI	$C066  48:          pha 
	$C067  8A:           txa 
	$C068  48:           pha 
	$C069  98:            tya 
	$C06A  48:            pha 
	$C06B  A9 00:          lda #$00
	$C06D  8D 03 20:       sta OAMADDR
	$C070  A5 4F:          lda 程序及卡通定义页选择控制器
	$C072  29 01:          and #$01
	$C074  09 02:          ora #$02
	$C076  8D 14 40:       sta $4014
	$C079  A0 01:          ldy #$01
	$C07B  8C 16 40:       sty $4016
	$C07E  88:             dey 
	$C07F  8C 16 40:       sty $4016
	$C082  AD 16 40:       lda $4016
	$C085  29 03:          and #$03
	$C087  85 6D:          sta $6D
	$C089  AD 16 40:       lda $4016
	$C08C  29 03:          and #$03
	$C08E  85 6E:          sta $6E
	$C090  AD 16 40:       lda $4016
	$C093  29 03:          and #$03
	$C095  85 6B:          sta $6B
	$C097  AD 16 40:       lda $4016
	$C09A  29 03:          and #$03
	$C09C  85 6C:          sta $6C
	$C09E  A0 01:          ldy #$01
-	$C0A0  AD 16 40:       lda $4016
	$C0A3  29 03:          and #$03
	$C0A5  D0 03:          bne +		; $C0AA
	$C0A7  88:             dey 
	$C0A8  10 F6:          bpl -		; $C0A0
+	$C0AA  84 6F:          sty $6F
	$C0AC  A0 01:          ldy #$01
-	$C0AE  AD 16 40:       lda $4016
	$C0B1  29 03:          and #$03
	$C0B3  D0 03:          bne +		; $C0B8
	$C0B5  88:             dey 
	$C0B6  10 F6:          bpl -		; $C0AE
+	$C0B8  84 70:          sty $70
	$C0BA  A4 71:          ldy 游戏演示标志
	$C0BC  F0 0A:          beq +		; $C0C8
	$C0BE  84 6D:          sty $6D
	$C0C0  88:             dey 
	$C0C1  84 6E:          sty $6E
	$C0C3  88:             dey 
	$C0C4  84 70:          sty $70
	$C0C6  84 6F:          sty $6F
+	$C0C8  A9 01:          lda #$01
	$C0CA  85 16:          sta $16
	$C0CC  68:            pla 
	$C0CD  A8:            tay 
	$C0CE  68:           pla 
	$C0CF  AA:           tax 
	$C0D0  68:          pla 
	$C0D1  40:          rti 
;------------------------------------------
_IRQ	$C0D2  4C D2 C0:    jmp _IRQ		; $C0D2 -> _IRQ
;------------------------------------------
_loc_00D5
	$C0D5  A9 01:       lda #$01
	$C0D7  85 A6:       sta $A6
	$C0D9  85 A7:       sta $A7
	$C0DB  20 9E F3:    jsr _func_339E
	$C0DE  A4 33:       ldy $33
	$C0E0  B9 40 C5:    lda _data_0540_indexed,y
	$C0E3  85 2D:       sta $2D
	$C0E5  A2 0A:       ldx #$0A
	$C0E7  A9 00:       lda #$00
-	$C0E9  95 71:       sta 游戏演示标志,x
	$C0EB  CA:          dex 
	$C0EC  D0 FB:       bne -		; $C0E9
	$C0EE  85 7D:       sta $7D
	$C0F0  85 80:       sta $80
	$C0F2  A4 71:       ldy 游戏演示标志
	$C0F4  D0 07:       bne +		; $C0FD
	$C0F6  A2 04:       ldx #$04
-	$C0F8  95 0F:       sta $0F,x
	$C0FA  CA:          dex 
	$C0FB  10 FB:       bpl -		; $C0F8
+	$C0FD  A5 71:       lda 游戏演示标志
	$C0FF  F0 0D:       beq ++		; $C10E
	$C101  A4 36:       ldy $36
	$C103  84 2D:       sty $2D
	$C105  C8:          iny 
	$C106  C0 0A:       cpy #$0A
	$C108  90 02:       bcc +		; $C10C
	$C10A  A0 00:       ldy #$00
+	$C10C  84 36:       sty $36
++	$C10E  A5 71:       lda 游戏演示标志
	$C110  D0 0B:       bne +		; $C11D
	$C112  A5 33:       lda $33
	$C114  F0 07:       beq +		; $C11D
	$C116  A0 00:       ldy #$00
	$C118  98:          tya 
	$C119  A2 40:       ldx #$40
	$C11B  D0 06:       bne ++		; $C123

+	$C11D  A0 03:       ldy #$03
	$C11F  A9 06:       lda #$06
	$C121  A2 80:       ldx #$80
++	$C123  84 B0:       sty $B0
	$C125  85 B1:       sta $B1
	$C127  86 B2:       stx $B2
	$C129  A9 FF:       lda #$FF
	$C12B  20 8E F4:    jsr _setLevelSoundData
	$C12E  A9 F8:       lda #$F8
	$C130  85 8F:       sta $8F
	$C132  85 90:       sta $90
	$C134  85 91:       sta $91
	$C136  A9 01:       lda #$01
	$C138  85 B3:       sta $B3
_loc_013A
	$C13A  20 9F EB:    jsr _func_2B9F
	$C13D  A9 60:       lda #$60
	$C13F  85 3C:       sta $3C
	$C141  A9 06:       lda #$06
	$C143  85 3D:       sta $3D
	$C145  A9 00:       lda #$00
	$C147  85 66:       sta $66
	$C149  A9 07:       lda #$07
	$C14B  85 67:       sta $67
	$C14D  A2 23:       ldx #$23
	$C14F  A9 00:       lda #$00
-	$C151  95 40:       sta $40,x
	$C153  CA:          dex 
	$C154  10 FB:       bpl -		; $C151
	$C156  A9 0B:       lda #$0B
	$C158  85 7C:       sta $7C
	$C15A  20 BA E9:    jsr _func_29BA
	$C15D  A9 F8:       lda #$F8
	$C15F  85 8F:       sta $8F
	$C161  85 90:       sta $90
	$C163  85 91:       sta $91
	$C165  E6 34:       inc $34
	$C167  A9 00:       lda #$00
	$C169  85 A7:       sta $A7
	$C16B  85 B5:       sta $B5
	$C16D  20 8E F4:    jsr _setLevelSoundData
	$C170  A9 0B:       lda #$0B
	$C172  85 A6:       sta $A6
	$C174  85 7C:       sta $7C
	$C176  A9 FA:       lda #$FA
	$C178  85 9E:       sta $9E
	$C17A  A9 D0:       lda #$D0
	$C17C  85 B4:       sta $B4
_loc_017E
	$C17E  20 1B C9:    jsr _queryKeyInput
	$C181  20 38 CA:    jsr _func_0A38
	$C184  20 06 C9:    jsr _func_0906
	$C187  A5 71:       lda 游戏演示标志
	$C189  F0 3B:       beq ++++		; $C1C6
	$C18B  A5 72:       lda $72
	$C18D  F0 09:       beq +		; $C198
	$C18F  C6 72:       dec $72
	$C191  A5 73:       lda $73
	$C193  85 70:       sta $70
	$C195  4C B6 C1:    jmp +++		; $C1B6

+	$C198  A5 4D:       lda $4D
	$C19A  D0 0A:       bne +		; $C1A6
	$C19C  A5 4C:       lda $4C
	$C19E  C9 28:       cmp #$28
	$C1A0  90 14:       bcc +++		; $C1B6
	$C1A2  A9 01:       lda #$01
	$C1A4  D0 08:       bne ++		; $C1AE

+	$C1A6  A5 4C:       lda $4C
	$C1A8  C9 D8:       cmp #$D8
	$C1AA  B0 0A:       bcs +++		; $C1B6
	$C1AC  A9 00:       lda #$00
++	$C1AE  85 70:       sta $70
	$C1B0  85 73:       sta $73
	$C1B2  A9 0E:       lda #$0E
	$C1B4  85 72:       sta $72
+++	$C1B6  A9 00:       lda #$00
	$C1B8  85 47:       sta $47
	$C1BA  A5 50:       lda $50
	$C1BC  D0 06:       bne +		; $C1C4
	$C1BE  A5 51:       lda $51
	$C1C0  C9 BE:       cmp #$BE
	$C1C2  90 02:       bcc ++++		; $C1C6
+	$C1C4  E6 47:       inc $47
++++	$C1C6  20 75 CC:    jsr _func_0C75
	$C1C9  20 1B D1:    jsr _func_111B
	$C1CC  20 14 FF:    jsr _func_3F14
	$C1CF  E6 4F:       inc 程序及卡通定义页选择控制器
	$C1D1  A5 56:       lda $56
	$C1D3  C9 60:       cmp #$60
	$C1D5  90 14:       bcc +		; $C1EB
	$C1D7  20 FC C1:    jsr _func_01FC
	$C1DA  20 8E F4:    jsr _setLevelSoundData
	$C1DD  A9 0B:       lda #$0B
	$C1DF  85 7C:       sta $7C
	$C1E1  A9 FA:       lda #$FA
	$C1E3  85 9E:       sta $9E
	$C1E5  A5 71:       lda 游戏演示标志
	$C1E7  F0 02:       beq +		; $C1EB
	$C1E9  85 74:       sta $74
+	$C1EB  A5 74:       lda $74
	$C1ED  F0 03:       beq +		; $C1F2
	$C1EF  4C 47 CE:    jmp _loc_0E47

+	$C1F2  A5 5B:       lda $5B
	$C1F4  D0 03:       bne +		; $C1F9 -> _loc_0F6C
	$C1F6  4C 7E C1:    jmp _loc_017E

+	$C1F9  4C 6C CF:    jmp _loc_0F6C
;------------------------------------------
_func_01FC
	$C1FC  20 AC F3:    jsr _func_33AC
	$C1FF  85 53:       sta $53
	$C201  85 54:       sta $54
	$C203  85 55:       sta $55
	$C205  85 56:       sta $56
	$C207  60:          rts 
;------------------------------------------
_func_0208
	$C208  A5 4B:       lda $4B
	$C20A  0A:          asl a
	$C20B  A5 4A:       lda $4A
	$C20D  2A:          rol a
	$C20E  8D 05 20:    sta PPUSCROLL
	$C211  A9 00:       lda #$00
	$C213  8D 05 20:    sta PPUSCROLL
	$C216  65 14:       adc ppuctrl_state
	$C218  8D 00 20:    sta PPUCTRL
	$C21B  A5 34:       lda $34
	$C21D  D0 01:       bne +		; $C220
	$C21F  60:          rts 

+	$C220  A5 56:       lda $56
	$C222  D0 16:       bne +		; $C23A
	$C224  A5 6E:       lda $6E
	$C226  F0 12:       beq +		; $C23A
	$C228  A5 51:       lda $51
	$C22A  38:          sec 
	$C22B  E9 01:       sbc #$01
	$C22D  85 51:       sta $51
	$C22F  A5 50:       lda $50
	$C231  E9 00:       sbc #$00
	$C233  85 50:       sta $50
	$C235  10 03:       bpl +		; $C23A
	$C237  20 AC F3:    jsr _func_33AC
+	$C23A  A5 56:       lda $56
	$C23C  D0 71:       bne +++		; $C2AF
	$C23E  A5 50:       lda $50
	$C240  85 A5:       sta $A5
	$C242  A5 51:       lda $51
	$C244  0A:          asl a
	$C245  26 A5:       rol $A5
	$C247  0A:          asl a
	$C248  26 A5:       rol $A5
	$C24A  0A:          asl a
	$C24B  26 A5:       rol $A5
	$C24D  0A:          asl a
	$C24E  26 A5:       rol $A5
	$C250  A4 A5:       ldy $A5
	$C252  A5 47:       lda $47
	$C254  F0 07:       beq +		; $C25D
	$C256  A5 75:       lda $75
	$C258  18:          clc 
	$C259  69 01:       adc #$01
	$C25B  D0 03:       bne ++		; $C260
+	$C25D  B9 1D C4:    lda _data_041D_indexed,y
++	$C260  85 18:       sta $18
	$C262  A5 51:       lda $51
	$C264  38:          sec 
	$C265  E5 18:       sbc $18
	$C267  85 51:       sta $51
	$C269  A5 50:       lda $50
	$C26B  E9 00:       sbc #$00
	$C26D  85 50:       sta $50
	$C26F  10 03:       bpl +		; $C274
	$C271  20 AC F3:    jsr _func_33AC
+	$C274  A5 6D:       lda $6D
	$C276  F0 37:       beq +++		; $C2AF
	$C278  A5 5C:       lda $5C
	$C27A  D0 33:       bne +++		; $C2AF
	$C27C  A5 75:       lda $75
	$C27E  F0 05:       beq +		; $C285
	$C280  98:          tya 
	$C281  18:          clc 
	$C282  69 20:       adc #$20
	$C284  A8:          tay 
+	$C285  A5 47:       lda $47
	$C287  D0 0B:       bne +		; $C294
	$C289  B9 3D C4:    lda _data_043D_indexed,y
	$C28C  85 18:       sta $18
	$C28E  B9 7D C4:    lda _data_047D_indexed,y
	$C291  4C 9C C2:    jmp ++		; $C29C

+	$C294  B9 BD C4:    lda _DataPointerTableLo_04BD,y
	$C297  85 18:       sta $18
	$C299  B9 FD C4:    lda _DataPointerTableHi_04BD,y
++	$C29C  85 19:       sta $19
	$C29E  18:          clc 
	$C29F  65 52:       adc $52
	$C2A1  85 52:       sta $52
	$C2A3  A5 51:       lda $51
	$C2A5  65 18:       adc $18
	$C2A7  85 51:       sta $51
	$C2A9  A5 50:       lda $50
	$C2AB  69 00:       adc #$00
	$C2AD  85 50:       sta $50
+++	$C2AF  A5 56:       lda $56
	$C2B1  F0 17:       beq +		; $C2CA
	$C2B3  A5 51:       lda $51
	$C2B5  38:          sec 
	$C2B6  E9 03:       sbc #$03
	$C2B8  85 51:       sta $51
	$C2BA  A5 50:       lda $50
	$C2BC  E9 00:       sbc #$00
	$C2BE  85 50:       sta $50
	$C2C0  10 08:       bpl +		; $C2CA
	$C2C2  A9 00:       lda #$00
	$C2C4  85 50:       sta $50
	$C2C6  85 51:       sta $51
	$C2C8  85 52:       sta $52
+	$C2CA  A5 50:       lda $50
	$C2CC  85 17:       sta $17
	$C2CE  85 19:       sta $19
	$C2D0  A5 51:       lda $51
	$C2D2  85 1A:       sta $1A
	$C2D4  0A:          asl a
	$C2D5  26 17:       rol $17
	$C2D7  0A:          asl a
	$C2D8  26 17:       rol $17
	$C2DA  85 18:       sta $18
	$C2DC  A5 56:       lda $56
	$C2DE  F0 03:       beq +		; $C2E3
-	$C2E0  4C 97 C3:    jmp _loc_0397

+	$C2E3  A5 70:       lda $70
	$C2E5  30 F9:       bmi -		; $C2E0 -> _loc_0397
	$C2E7  A5 75:       lda $75
	$C2E9  F0 15:       beq +		; $C300
	$C2EB  A5 1A:       lda $1A
	$C2ED  38:          sec 
	$C2EE  E9 8C:       sbc #$8C
	$C2F0  85 1A:       sta $1A
	$C2F2  A5 19:       lda $19
	$C2F4  E9 00:       sbc #$00
	$C2F6  85 19:       sta $19
	$C2F8  10 06:       bpl +		; $C300
	$C2FA  A9 00:       lda #$00
	$C2FC  85 19:       sta $19
	$C2FE  85 1A:       sta $1A
+	$C300  A0 00:       ldy #$00
	$C302  A5 71:       lda 游戏演示标志
	$C304  D0 02:       bne +		; $C308
	$C306  A4 33:       ldy $33
+	$C308  B9 3D C5:    lda _data_053D_indexed,y
	$C30B  18:          clc 
	$C30C  65 1A:       adc $1A
	$C30E  85 1A:       sta $1A
	$C310  90 02:       bcc +		; $C314
	$C312  E6 19:       inc $19
+	$C314  A5 19:       lda $19
	$C316  F0 35:       beq ++++		; $C34D
	$C318  A0 00:       ldy #$00
	$C31A  B1 3C:       lda ($3C),y
	$C31C  10 05:       bpl +		; $C323
	$C31E  49 FF:       eor #$FF
	$C320  18:          clc 
	$C321  69 01:       adc #$01
+	$C323  C9 28:       cmp #$28
	$C325  B0 18:       bcs ++		; $C33F
	$C327  C9 18:       cmp #$18
	$C329  B0 0C:       bcs +		; $C337
	$C32B  C9 08:       cmp #$08
	$C32D  90 1E:       bcc ++++		; $C34D
	$C32F  A5 1A:       lda $1A
	$C331  C9 72:       cmp #$72
	$C333  B0 10:       bcs +++		; $C345
	$C335  90 16:       bcc ++++		; $C34D
+	$C337  A5 1A:       lda $1A
	$C339  C9 54:       cmp #$54
	$C33B  B0 08:       bcs +++		; $C345
	$C33D  90 0E:       bcc ++++		; $C34D
++	$C33F  A5 1A:       lda $1A
	$C341  C9 36:       cmp #$36
	$C343  90 08:       bcc ++++		; $C34D
+++	$C345  A9 04:       lda #$04
	$C347  20 8E F4:    jsr _setLevelSoundData
	$C34A  4C 7A C3:    jmp _loc_037A

++++	$C34D  A5 70:       lda $70
	$C34F  D0 16:       bne +		; $C367
	$C351  A5 4E:       lda $4E
	$C353  18:          clc 
	$C354  65 18:       adc $18
	$C356  85 4E:       sta $4E
	$C358  A5 4C:       lda $4C
	$C35A  65 17:       adc $17
	$C35C  85 4C:       sta $4C
	$C35E  A5 4D:       lda $4D
	$C360  69 00:       adc #$00
	$C362  85 4D:       sta $4D
	$C364  4C 7A C3:    jmp _loc_037A

+	$C367  A5 4E:       lda $4E
	$C369  38:          sec 
	$C36A  E5 18:       sbc $18
	$C36C  85 4E:       sta $4E
	$C36E  A5 4C:       lda $4C
	$C370  E5 17:       sbc $17
	$C372  85 4C:       sta $4C
	$C374  A5 4D:       lda $4D
	$C376  E9 00:       sbc #$00
	$C378  85 4D:       sta $4D
_loc_037A
	$C37A  A5 50:       lda $50
	$C37C  D0 06:       bne +		; $C384
	$C37E  A5 51:       lda $51
	$C380  C9 C8:       cmp #$C8
	$C382  90 13:       bcc _loc_0397
+	$C384  A5 52:       lda $52
	$C386  38:          sec 
	$C387  E9 40:       sbc #$40
	$C389  85 52:       sta $52
	$C38B  A5 51:       lda $51
	$C38D  E9 00:       sbc #$00
	$C38F  85 51:       sta $51
	$C391  A5 50:       lda $50
	$C393  E9 00:       sbc #$00
	$C395  85 50:       sta $50
_loc_0397
	$C397  A0 00:       ldy #$00
	$C399  B1 3C:       lda ($3C),y
	$C39B  10 05:       bpl +		; $C3A2
	$C39D  49 FF:       eor #$FF
	$C39F  18:          clc 
	$C3A0  69 01:       adc #$01
+	$C3A2  85 17:       sta $17
	$C3A4  A5 50:       lda $50
	$C3A6  4A:          lsr a
	$C3A7  A5 51:       lda $51
	$C3A9  6A:          ror a
	$C3AA  4A:          lsr a
	$C3AB  4A:          lsr a
	$C3AC  4A:          lsr a
	$C3AD  85 18:       sta $18
	$C3AF  A9 00:       lda #$00
	$C3B1  85 19:       sta $19
	$C3B3  85 1A:       sta $1A
	$C3B5  85 1B:       sta $1B
	$C3B7  A2 05:       ldx #$05
-	$C3B9  46 17:       lsr $17
	$C3BB  90 0D:       bcc +		; $C3CA
	$C3BD  A5 1A:       lda $1A
	$C3BF  18:          clc 
	$C3C0  65 18:       adc $18
	$C3C2  85 1A:       sta $1A
	$C3C4  A5 1B:       lda $1B
	$C3C6  65 19:       adc $19
	$C3C8  85 1B:       sta $1B
+	$C3CA  06 18:       asl $18
	$C3CC  26 19:       rol $19
	$C3CE  CA:          dex 
	$C3CF  10 E8:       bpl -		; $C3B9
	$C3D1  B1 3C:       lda ($3C),y
	$C3D3  30 16:       bmi +		; $C3EB
	$C3D5  A5 4E:       lda $4E
	$C3D7  38:          sec 
	$C3D8  E5 1A:       sbc $1A
	$C3DA  85 4E:       sta $4E
	$C3DC  A5 4C:       lda $4C
	$C3DE  E5 1B:       sbc $1B
	$C3E0  85 4C:       sta $4C
	$C3E2  A5 4D:       lda $4D
	$C3E4  E9 00:       sbc #$00
	$C3E6  85 4D:       sta $4D
	$C3E8  4C FE C3:    jmp ++		; $C3FE

+	$C3EB  A5 4E:       lda $4E
	$C3ED  18:          clc 
	$C3EE  65 1A:       adc $1A
	$C3F0  85 4E:       sta $4E
	$C3F2  A5 4C:       lda $4C
	$C3F4  65 1B:       adc $1B
	$C3F6  85 4C:       sta $4C
	$C3F8  A5 4D:       lda $4D
	$C3FA  69 00:       adc #$00
	$C3FC  85 4D:       sta $4D
++	$C3FE  A5 4D:       lda $4D
	$C400  30 0C:       bmi +		; $C40E
	$C402  A5 4C:       lda $4C
	$C404  C9 A0:       cmp #$A0
	$C406  90 14:       bcc +++		; $C41C -> rts
	$C408  A9 A0:       lda #$A0
	$C40A  85 4C:       sta $4C
	$C40C  D0 0A:       bne ++		; $C418

+	$C40E  A5 4C:       lda $4C
	$C410  C9 60:       cmp #$60
	$C412  B0 08:       bcs +++		; $C41C -> rts
	$C414  A9 60:       lda #$60
	$C416  85 4C:       sta $4C
++	$C418  A9 00:       lda #$00
	$C41A  85 4E:       sta $4E
+++	$C41C  60:          rts 
;------------------------------------------
_data_041D_indexed
	$C41D               .byte $01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02
	$C42D               .byte $03,$03,$03,$03,$04,$04,$04,$04,$05,$05,$06,$06,$07,$07,$08,$08
_data_043D_indexed
	$C43D               .byte $02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$02,$02,$02,$00,$00
	$C44D               .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	$C45D               .byte $02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$03,$02,$02,$00
	$C46D               .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
_data_047D_indexed
	$C47D               .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$40,$20,$00,$00
	$C48D               .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	$C49D               .byte $20,$40,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$40,$00
	$C4AD               .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
_DataPointerTableLo_04BD
	$C4BD  01:          .byte < (PPUMASK)
	$C4BE  01:          .byte < ($3001)
	$C4BF  01:          .byte < ($4001)
	$C4C0  01:          .byte < ($5001)
	$C4C1  01:          .byte < ($6001)
	$C4C2  01:          .byte < ($7001)
	$C4C3  01:          .byte < (DataTableEntry_0001)
	$C4C4  01:          .byte < (DataTableEntry_1801)
	$C4C5  01:          .byte < (DataTableEntry_3001)
	$C4C6  01:          .byte < (DataTableEntry_0801)
	$C4C7  01:          .byte < (DataTableEntry_2001)
	$C4C8  01:          .byte < (DataTableEntry_3801)
	$C4C9  02:          .byte < ($1002)
	$C4CA  02:          .byte < ($3002)
	$C4CB  02:          .byte < ($5002)
	$C4CC  02:          .byte < ($7002)
	$C4CD  02:          .byte < ($4002)
	$C4CE  02:          .byte < (PPUSTATUS)
	$C4CF  02:          .byte < (DataTableEntry_3002)
	$C4D0  01:          .byte < (DataTableEntry_0001)
	$C4D1  01:          .byte < (DataTableEntry_1001)
	$C4D2  01:          .byte < ($6801)
	$C4D3  01:          .byte < ($4001)
	$C4D4  01:          .byte < (PPUMASK)
	$C4D5  01:          .byte < ($1801)
	$C4D6  01:          .byte < ($1001)
	$C4D7  01:          .byte < ($4001)
	$C4D8  01:          .byte < (DataTableEntry_0001)
	$C4D9  01:          .byte < (DataTableEntry_0001)
	$C4DA  01:          .byte < (DataTableEntry_0001)
	$C4DB  01:          .byte < ($4001)
	$C4DC  00:          .byte < (DataTableEntry_3F00)
	$C4DD               .byte $02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
	$C4ED               .byte $03,$03,$03,$03,$03,$03,$03,$02,$03,$03,$03,$03,$03,$03,$03,$00
_DataPointerTableHi_04BD
	$C4FD  20:          .byte > (PPUMASK)
	$C4FE  30:          .byte > ($3001)
	$C4FF  40:          .byte > ($4001)
	$C500  50:          .byte > ($5001)
	$C501  60:          .byte > ($6001)
	$C502  70:          .byte > ($7001)
	$C503  80:          .byte > (DataTableEntry_0001)
	$C504  98:          .byte > (DataTableEntry_1801)
	$C505  B0:          .byte > (DataTableEntry_3001)
	$C506  C8:          .byte > (DataTableEntry_0801)
	$C507  E0:          .byte > (DataTableEntry_2001)
	$C508  F8:          .byte > (DataTableEntry_3801)
	$C509  10:          .byte > ($1002)
	$C50A  30:          .byte > ($3002)
	$C50B  50:          .byte > ($5002)
	$C50C  70:          .byte > ($7002)
	$C50D  40:          .byte > ($4002)
	$C50E  20:          .byte > (PPUSTATUS)
	$C50F  F0:          .byte > (DataTableEntry_3002)
	$C510  C0:          .byte > (DataTableEntry_0001)
	$C511  90:          .byte > (DataTableEntry_1001)
	$C512  68:          .byte > ($6801)
	$C513  40:          .byte > ($4001)
	$C514  20:          .byte > (PPUMASK)
	$C515  18:          .byte > ($1801)
	$C516  10:          .byte > ($1001)
	$C517  40:          .byte > ($4001)
	$C518  80:          .byte > (DataTableEntry_0001)
	$C519  80:          .byte > (DataTableEntry_0001)
	$C51A  80:          .byte > (DataTableEntry_0001)
	$C51B  40:          .byte > ($4001)
	$C51C  FF:          .byte > (DataTableEntry_3F00)
	$C51D               .byte $40,$60,$80,$A0,$C0,$E0,$00,$20,$40,$60,$80,$A0,$B0,$C0,$D0,$E0
	$C52D               .byte $C0,$A0,$80,$60,$40,$20,$00,$E0,$00,$20,$40,$40,$40,$40,$20,$FF
_data_053D_indexed
	$C53D               .byte $00,$14,$28
_data_0540_indexed
	$C540               .byte $00,$02,$05
_func_0543
	$C543  20 1B C9:    jsr _queryKeyInput
	$C546  A2 00:       ldx #$00
	$C548  86 15:       stx ppumask_state
	$C54A  8E 01 20:    stx PPUMASK
	$C54D  A9 20:       lda #$20
	$C54F  85 22:       sta $22
	$C551  86 23:       stx $23
	$C553  E8:          inx 
--	$C554  A5 22:       lda $22
	$C556  A4 23:       ldy $23
	$C558  20 64 E9:    jsr _func_2964
	$C55B  A0 00:       ldy #$00
	$C55D  A9 2D:       lda #$2D
-	$C55F  20 FB D0:    jsr _func_10FB
	$C562  C8:          iny 
	$C563  D0 FA:       bne -		; $C55F
	$C565  20 1B C9:    jsr _queryKeyInput
	$C568  A5 22:       lda $22
	$C56A  18:          clc 
	$C56B  69 04:       adc #$04
	$C56D  85 22:       sta $22
	$C56F  CA:          dex 
	$C570  10 E2:       bpl --		; $C554
	$C572  A9 3F:       lda #$3F
	$C574  A0 00:       ldy #$00
	$C576  20 64 E9:    jsr _func_2964
	$C579  20 6B E9:    jsr _func_296B
	$C57C  A5 2E:       lda $2E
	$C57E  29 0F:       and #$0F
	$C580  C9 06:       cmp #$06
	$C582  90 02:       bcc +		; $C586
	$C584  A9 00:       lda #$00
+	$C586  0A:          asl a
	$C587  0A:          asl a
	$C588  0A:          asl a
	$C589  AA:          tax 
	$C58A  A0 07:       ldy #$07
-	$C58C  BD C6 C8:    lda _data_08C6_indexed,x
	$C58F  8D 07 20:    sta PPUDATA
	$C592  E8:          inx 
	$C593  88:          dey 
	$C594  10 F6:       bpl -		; $C58C
	$C596  A0 00:       ldy #$00
-	$C598  B9 AE C8:    lda _data_08AE_indexed,y
	$C59B  8D 07 20:    sta PPUDATA
	$C59E  C8:          iny 
	$C59F  C0 18:       cpy #$18
	$C5A1  90 F5:       bcc -		; $C598
	$C5A3  A9 3F:       lda #$3F
	$C5A5  A0 00:       ldy #$00
	$C5A7  20 64 E9:    jsr _func_2964
	$C5AA  98:          tya 
	$C5AB  20 64 E9:    jsr _func_2964
	$C5AE  A2 01:       ldx #$01
--	$C5B0  A9 23:       lda #$23
	$C5B2  A0 C0:       ldy #$C0
	$C5B4  20 64 E9:    jsr _func_2964
	$C5B7  A0 00:       ldy #$00
-	$C5B9  A9 00:       lda #$00
	$C5BB  C0 20:       cpy #$20
	$C5BD  B0 0F:       bcs +		; $C5CE
	$C5BF  A9 05:       lda #$05
	$C5C1  C0 18:       cpy #$18
	$C5C3  B0 09:       bcs +		; $C5CE
	$C5C5  A9 55:       lda #$55
	$C5C7  C0 10:       cpy #$10
	$C5C9  B0 03:       bcs +		; $C5CE
	$C5CB  B9 F6 C8:    lda _data_08F6_indexed,y
+	$C5CE  8D 07 20:    sta PPUDATA
	$C5D1  C8:          iny 
	$C5D2  C0 40:       cpy #$40
	$C5D4  90 E3:       bcc -		; $C5B9
	$C5D6  A9 27:       lda #$27
	$C5D8  A0 C0:       ldy #$C0
	$C5DA  20 64 E9:    jsr _func_2964
	$C5DD  A9 55:       lda #$55
	$C5DF  A0 00:       ldy #$00
-	$C5E1  8D 07 20:    sta PPUDATA
	$C5E4  C0 17:       cpy #$17
	$C5E6  D0 02:       bne +		; $C5EA
	$C5E8  A9 05:       lda #$05
+	$C5EA  C0 1F:       cpy #$1F
	$C5EC  D0 02:       bne +		; $C5F0
	$C5EE  A9 00:       lda #$00
+	$C5F0  C8:          iny 
	$C5F1  C0 40:       cpy #$40
	$C5F3  90 EC:       bcc -		; $C5E1
	$C5F5  CA:          dex 
	$C5F6  10 B8:       bpl --		; $C5B0
	$C5F8  20 1B C9:    jsr _queryKeyInput
	$C5FB  A9 20:       lda #$20
	$C5FD  A0 89:       ldy #$89
	$C5FF  20 64 E9:    jsr _func_2964
	$C602  A0 3D:       ldy #$3D
	$C604  8C 07 20:    sty PPUDATA
	$C607  C8:          iny 
	$C608  8C 07 20:    sty PPUDATA
	$C60B  A9 20:       lda #$20
	$C60D  A0 A9:       ldy #$A9
	$C60F  20 64 E9:    jsr _func_2964
	$C612  A0 3F:       ldy #$3F
	$C614  8C 07 20:    sty PPUDATA
	$C617  C8:          iny 
	$C618  8C 07 20:    sty PPUDATA
	$C61B  A9 20:       lda #$20
	$C61D  A0 AC:       ldy #$AC
	$C61F  20 64 E9:    jsr _func_2964
	$C622  A0 11:       ldy #$11
	$C624  8C 07 20:    sty PPUDATA
	$C627  C8:          iny 
	$C628  8C 07 20:    sty PPUDATA
	$C62B  A9 20:       lda #$20
	$C62D  A0 4C:       ldy #$4C
	$C62F  20 64 E9:    jsr _func_2964
	$C632  A0 07:       ldy #$07
-	$C634  B9 FF C7:    lda _data_07FF_indexed,y
	$C637  8D 07 20:    sta PPUDATA
	$C63A  88:          dey 
	$C63B  10 F7:       bpl -		; $C634
	$C63D  A9 20:       lda #$20
	$C63F  A0 8F:       ldy #$8F
	$C641  20 64 E9:    jsr _func_2964
	$C644  A0 04:       ldy #$04
-	$C646  B9 07 C8:    lda _data_0807_indexed,y
	$C649  8D 07 20:    sta PPUDATA
	$C64C  88:          dey 
	$C64D  10 F7:       bpl -		; $C646
	$C64F  20 1B C9:    jsr _queryKeyInput
	$C652  A9 21:       lda #$21
	$C654  A0 C0:       ldy #$C0
	$C656  20 64 E9:    jsr _func_2964
	$C659  A0 1F:       ldy #$1F
	$C65B  A9 2B:       lda #$2B
-	$C65D  8D 07 20:    sta PPUDATA
	$C660  88:          dey 
	$C661  10 FA:       bpl -		; $C65D
	$C663  A9 25:       lda #$25
	$C665  A0 C0:       ldy #$C0
	$C667  20 64 E9:    jsr _func_2964
	$C66A  A0 1F:       ldy #$1F
	$C66C  A9 2B:       lda #$2B
-	$C66E  8D 07 20:    sta PPUDATA
	$C671  88:          dey 
	$C672  10 FA:       bpl -		; $C66E
	$C674  20 1B C9:    jsr _queryKeyInput
	$C677  A9 23:       lda #<_data_3023
	$C679  85 22:       sta $22
	$C67B  A9 B0:       lda #>_data_3023
	$C67D  85 23:       sta $23
	$C67F  A2 0E:       ldx #$0E
--	$C681  A5 22:       lda $22
	$C683  A4 23:       ldy $23
	$C685  20 64 E9:    jsr _func_2964
	$C688  8A:          txa 
	$C689  A8:          tay 
	$C68A  A9 2C:       lda #$2C
-	$C68C  8D 07 20:    sta PPUDATA
	$C68F  88:          dey 
	$C690  10 FA:       bpl -		; $C68C
	$C692  A5 23:       lda $23
	$C694  38:          sec 
	$C695  E9 1F:       sbc #$1F
	$C697  85 23:       sta $23
	$C699  B0 02:       bcs +		; $C69D
	$C69B  C6 22:       dec $22
+	$C69D  CA:          dex 
	$C69E  10 E1:       bpl --		; $C681
	$C6A0  A2 0E:       ldx #$0E
	$C6A2  A9 27:       lda #<_data_2027
	$C6A4  85 22:       sta $22
	$C6A6  A9 A0:       lda #>_data_2027
	$C6A8  85 23:       sta $23
--	$C6AA  A5 22:       lda $22
	$C6AC  A4 23:       ldy $23
	$C6AE  20 64 E9:    jsr _func_2964
	$C6B1  8A:          txa 
	$C6B2  A8:          tay 
	$C6B3  A9 2C:       lda #$2C
-	$C6B5  8D 07 20:    sta PPUDATA
	$C6B8  88:          dey 
	$C6B9  10 FA:       bpl -		; $C6B5
	$C6BB  A5 23:       lda $23
	$C6BD  38:          sec 
	$C6BE  E9 20:       sbc #$20
	$C6C0  85 23:       sta $23
	$C6C2  B0 02:       bcs +		; $C6C6
	$C6C4  C6 22:       dec $22
+	$C6C6  CA:          dex 
	$C6C7  10 E1:       bpl --		; $C6AA
	$C6C9  A5 14:       lda ppuctrl_state
	$C6CB  09 04:       ora #$04
	$C6CD  8D 00 20:    sta PPUCTRL
	$C6D0  A9 21:       lda #<_data_1E21_indexed
	$C6D2  85 22:       sta $22
	$C6D4  A9 DE:       lda #>_data_1E21_indexed
	$C6D6  85 23:       sta $23
	$C6D8  A0 00:       ldy #$00
	$C6DA  A2 00:       ldx #$00
--	$C6DC  86 18:       stx $18
	$C6DE  BD 0C C8:    lda _data_080C_indexed,x
	$C6E1  85 17:       sta $17
	$C6E3  A5 22:       lda $22
	$C6E5  8D 06 20:    sta PPUADDR
	$C6E8  A5 23:       lda $23
	$C6EA  8D 06 20:    sta PPUADDR
	$C6ED  A2 00:       ldx #$00
-	$C6EF  B9 1C C8:    lda _data_081C_indexed,y
	$C6F2  8D 07 20:    sta PPUDATA
	$C6F5  C8:          iny 
	$C6F6  E8:          inx 
	$C6F7  E4 17:       cpx $17
	$C6F9  90 F4:       bcc -		; $C6EF
	$C6FB  A5 23:       lda $23
	$C6FD  18:          clc 
	$C6FE  69 1F:       adc #$1F
	$C700  85 23:       sta $23
	$C702  90 02:       bcc +		; $C706
	$C704  E6 22:       inc $22
+	$C706  A6 18:       ldx $18
	$C708  E8:          inx 
	$C709  E0 10:       cpx #$10
	$C70B  90 CF:       bcc --		; $C6DC
	$C70D  A9 25:       lda #<_data_0025
	$C70F  85 22:       sta $22
	$C711  A9 C0:       lda #>_data_0025
	$C713  85 23:       sta $23
	$C715  A0 00:       ldy #$00
	$C717  A2 00:       ldx #$00
--	$C719  86 18:       stx $18
	$C71B  BD 0C C8:    lda _data_080C_indexed,x
	$C71E  85 17:       sta $17
	$C720  A5 22:       lda $22
	$C722  8D 06 20:    sta PPUADDR
	$C725  A5 23:       lda $23
	$C727  8D 06 20:    sta PPUADDR
	$C72A  A2 00:       ldx #$00
-	$C72C  B9 1C C8:    lda _data_081C_indexed,y
	$C72F  10 03:       bpl +		; $C734
	$C731  18:          clc 
	$C732  69 11:       adc #$11
+	$C734  8D 07 20:    sta PPUDATA
	$C737  C8:          iny 
	$C738  E8:          inx 
	$C739  E4 17:       cpx $17
	$C73B  90 EF:       bcc -		; $C72C
	$C73D  A5 23:       lda $23
	$C73F  18:          clc 
	$C740  69 21:       adc #$21
	$C742  85 23:       sta $23
	$C744  90 02:       bcc +		; $C748
	$C746  E6 22:       inc $22
+	$C748  A6 18:       ldx $18
	$C74A  E8:          inx 
	$C74B  E0 10:       cpx #$10
	$C74D  90 CA:       bcc --		; $C719
	$C74F  A9 21:       lda #$21
	$C751  A0 DF:       ldy #$DF
	$C753  20 64 E9:    jsr _func_2964
	$C756  A9 60:       lda #$60
	$C758  8D 07 20:    sta PPUDATA
	$C75B  A5 14:       lda ppuctrl_state
	$C75D  8D 00 20:    sta PPUCTRL
	$C760  20 1B C9:    jsr _queryKeyInput
	$C763  A9 21:       lda #$21
	$C765  A0 40:       ldy #$40
	$C767  20 64 E9:    jsr _func_2964
	$C76A  A0 00:       ldy #$00
-	$C76C  B9 49 C8:    lda _data_0849_indexed,y
	$C76F  F0 06:       beq +		; $C777
	$C771  20 DF C7:    jsr _func_07DF
	$C774  4C 6C C7:    jmp -		; $C76C

+	$C777  A9 25:       lda #$25
	$C779  A0 40:       ldy #$40
	$C77B  20 64 E9:    jsr _func_2964
	$C77E  A0 00:       ldy #$00
-	$C780  B9 78 C8:    lda _data_0878_indexed,y
	$C783  F0 06:       beq +		; $C78B
	$C785  20 DF C7:    jsr _func_07DF
	$C788  4C 80 C7:    jmp -		; $C780

+	$C78B  A9 6D:       lda #$6D
	$C78D  8D 00 02:    sta $0200
	$C790  8D 00 03:    sta $0300
	$C793  A9 20:       lda #$20
	$C795  8D 02 02:    sta $0202
	$C798  8D 02 03:    sta $0302
	$C79B  A9 00:       lda #$00
	$C79D  8D 03 02:    sta $0203
	$C7A0  8D 03 03:    sta $0303
	$C7A3  A9 FB:       lda #$FB
	$C7A5  8D 01 02:    sta $0201
	$C7A8  8D 01 03:    sta $0301
	$C7AB  20 1B C9:    jsr _queryKeyInput
	$C7AE  20 95 F0:    jsr _func_3095
	$C7B1  20 38 CA:    jsr _func_0A38
_func_07B4
	$C7B4  A4 2D:       ldy $2D
	$C7B6  B9 CB C7:    lda _data_07CB_indexed,y
	$C7B9  85 C4:       sta $C4
	$C7BB  B9 D5 C7:    lda _data_07D5_indexed,y
	$C7BE  85 C6:       sta $C6
	$C7C0  A9 80:       lda #$80
	$C7C2  85 C5:       sta $C5
	$C7C4  85 C7:       sta $C7
	$C7C6  A9 00:       lda #$00
	$C7C8  85 C8:       sta $C8
	$C7CA  60:          rts 
;------------------------------------------
_data_07CB_indexed
	$C7CB               .byte $C0,$B3,$C0,$B8,$C0,$D8,$B3,$D8,$B3,$D0
_data_07D5_indexed
	$C7D5               .byte $0F,$0F,$0F,$1F,$0F,$0F,$0F,$0F,$0F,$0F
_func_07DF
	$C7DF  C9 20:       cmp #$20
	$C7E1  B0 17:       bcs +++		; $C7FA
	$C7E3  48:          pha 
	$C7E4  29 0F:        and #$0F
	$C7E6  AA:           tax 
	$C7E7  68:          pla 
	$C7E8  29 10:       and #$10
	$C7EA  D0 04:       bne +		; $C7F0
	$C7EC  A9 2D:       lda #$2D
	$C7EE  D0 02:       bne ++		; $C7F2

+	$C7F0  A9 2F:       lda #$2F
++ -	$C7F2  8D 07 20:    sta PPUDATA
	$C7F5  CA:          dex 
	$C7F6  10 FA:       bpl -		; $C7F2
	$C7F8  30 03:       bmi ++++		; $C7FD
+++	$C7FA  8D 07 20:    sta PPUDATA
++++	$C7FD  C8:          iny 
	$C7FE  60:          rts 
;------------------------------------------
_data_07FF_indexed
	$C7FF               .byte $0E
_data_0800
	$C800               .byte $16
DataTableEntry_0801
	$C801               .byte $12,$1D,$2D,$2D,$2A,$29
_data_0807_indexed
	$C807               .byte $0E,$1B,$18,$0C,$1C
_data_080C_indexed
	$C80C               .byte $02,$02
_data_080E
	$C80E               .byte $02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$03,$02,$01
_data_081C_indexed
	$C81C               .byte $A0,$A2,$A1,$A4,$A3,$A6,$A5,$A8,$A7,$AA,$AC,$A9,$AB,$A2,$A9,$AD
	$C82C               .byte $A4,$A9,$AE,$A6,$A9,$AF,$A8,$A9,$B0,$AA,$AC,$A9,$2E,$AB,$A2,$A9
	$C83C               .byte $2E,$AD,$A4,$A9,$2E,$AE,$A6,$A9,$2E,$AF,$A9,$2E,$A9
_data_0849_indexed
	$C849               .byte $08,$5C,$5D,$5E,$5F,$0F,$09,$5A,$5B,$0A,$EC,$E7,$ED,$EF,$E7,$0A
	$C859               .byte $E5,$E6,$E7,$2D,$0A,$E5,$11,$EE,$11,$EF,$E4,$EF,$E7,$EC,$E7,$02
	$C869               .byte $E3,$E4,$12,$E8,$E9,$EA,$05,$EB,$E8,$E4,$16,$EE,$13,$F0,$00
_data_0878_indexed
	$C878               .byte $03,$5A,$5B,$0F,$0F,$01,$5C,$5D,$5E,$5B,$08,$5C,$5D,$5E,$5F,$0A
	$C888               .byte $ED,$EF,$E7,$2D,$F1,$F3,$04,$55,$56,$57,$58,$59,$04,$ED,$EF,$E6
	$C898               .byte $F3,$04,$EC,$E4,$12,$F2,$11,$EF,$E9,$EA,$F3,$01,$54,$54,$54,$03
	$C8A8               .byte $EB,$F2,$13,$F4,$01,$00
_data_08AE_indexed
	$C8AE               .byte $00,$0F,$26,$2C,$00,$0F,$38,$30,$00,$0F,$16,$30,$00,$0F,$12,$38
	$C8BE               .byte $00,$0F,$27,$30,$00,$30,$16,$38
_data_08C6_indexed
	$C8C6               .byte $00,$2A,$01,$30,$00,$21,$30,$1C,$00,$17,$29,$30,$00,$22,$30,$1B
	$C8D6               .byte $00,$19,$17,$30,$00,$21,$30,$08,$00,$16,$07,$35,$00,$25,$36,$06
	$C8E6               .byte $00,$22,$0C,$31,$00,$01,$11,$0F,$00,$28,$08,$30,$00,$37,$30,$07
_data_08F6_indexed
	$C8F6               .byte $95,$A5,$B5,$E5,$F5,$A5,$A5,$65,$59,$5A,$5A,$5E,$5F,$5A,$5A,$56
_func_0906
	$C906  A9 20:       lda #$20
	$C908  A0 00:       ldy #$00
	$C90A  20 64 E9:    jsr _func_2964
	$C90D  8C 05 20:    sty PPUSCROLL
	$C910  8C 05 20:    sty PPUSCROLL
	$C913  A9 1E:       lda #$1E
	$C915  85 15:       sta ppumask_state
	$C917  8D 01 20:    sta PPUMASK
	$C91A  60:          rts 
;------------------------------------------
_queryKeyInput
	$C91B  A0 01:       ldy #$01
----	$C91D  A9 00:       lda #$00
	$C91F  85 16:       sta $16
	$C921  A5 71:       lda 游戏演示标志
	$C923  F0 1D:       beq ++		; $C942
	$C925  A5 2A:       lda $2A
	$C927  D0 0A:       bne +		; $C933
	$C929  A5 6B:       lda $6B
	$C92B  F0 06:       beq +		; $C933
	$C92D  A2 FF:       ldx #$FF
	$C92F  9A:          txs 		; set Stack Pointer at $1FF
	$C930  4C 0A E6:    jmp _main_reset_code

+	$C933  A5 6C:       lda $6C
	$C935  F0 0B:       beq ++		; $C942
	$C937  A2 FF:       ldx #$FF
	$C939  9A:          txs 		; set Stack Pointer at $1FF
	$C93A  E8:          inx 
	$C93B  86 71:       stx 游戏演示标志
	$C93D  86 2A:       stx $2A
	$C93F  4C D5 C0:    jmp _loc_00D5

++ -	$C942  A5 16:       lda $16
	$C944  F0 FC:       beq -		; $C942
	$C946  A5 A7:       lda $A7
	$C948  D0 08:       bne +		; $C952
	$C94A  A5 A6:       lda $A6
	$C94C  D0 08:       bne ++		; $C956
	$C94E  A5 71:       lda 游戏演示标志
	$C950  F0 0B:       beq +++		; $C95D
+ ---	$C952  88:          dey 
	$C953  D0 C8:       bne ----		; $C91D
	$C955  60:          rts 

++	$C956  A5 6C:       lda $6C
	$C958  85 A6:       sta $A6
	$C95A  4C 52 C9:    jmp ---		; $C952

+++	$C95D  A5 6C:       lda $6C
	$C95F  D0 03:       bne +		; $C964
	$C961  4C 52 C9:    jmp ---		; $C952

+	$C964  85 A7:       sta $A7
	$C966  98:          tya 
	$C967  48:          pha 
	$C968  8A:           txa 
	$C969  48:           pha 
	$C96A  A9 01:         lda #$01
	$C96C  85 32:         sta $32
	$C96E  A9 20:         lda #$20
	$C970  85 A8:         sta $A8
	$C972  A9 55:         lda #$55
	$C974  85 A9:         sta $A9
	$C976  A2 03:         ldx #$03
--	$C978  A5 A8:         lda $A8
	$C97A  A4 A9:         ldy $A9
	$C97C  20 64 E9:      jsr _func_2964
	$C97F  A0 08:         ldy #$08
-	$C981  A9 2D:         lda #$2D
	$C983  8D 07 20:      sta PPUDATA
	$C986  88:            dey 
	$C987  10 F8:         bpl -		; $C981
	$C989  A5 A9:         lda $A9
	$C98B  18:            clc 
	$C98C  69 20:         adc #$20
	$C98E  85 A9:         sta $A9
	$C990  CA:            dex 
	$C991  10 E5:         bpl --		; $C978
	$C993  A9 20:         lda #$20
	$C995  A0 77:         ldy #$77
	$C997  20 64 E9:      jsr _func_2964
	$C99A  A0 04:         ldy #$04
-	$C99C  B9 F2 C9:      lda _data_09F2_indexed,y
	$C99F  8D 07 20:      sta PPUDATA
	$C9A2  88:            dey 
	$C9A3  10 F7:         bpl -		; $C99C
	$C9A5  A9 08:         lda #$08
	$C9A7  20 8E F4:      jsr _setLevelSoundData
	$C9AA  20 04 CA:      jsr _func_0A04
	$C9AD  A9 1E:         lda #$1E
	$C9AF  20 F7 C9:      jsr _func_09F7
	$C9B2  A9 01:         lda #$01
	$C9B4  85 A8:         sta $A8
-	$C9B6  A5 A8:         lda $A8
	$C9B8  D0 04:         bne +		; $C9BE
	$C9BA  A5 6C:         lda $6C
	$C9BC  D0 0A:         bne ++		; $C9C8
+	$C9BE  A5 6C:         lda $6C
	$C9C0  85 A8:         sta $A8
	$C9C2  20 01 CA:      jsr _func_0A01
	$C9C5  4C B6 C9:      jmp -		; $C9B6

++	$C9C8  20 1B C9:      jsr _queryKeyInput
	$C9CB  20 95 F0:      jsr _func_3095
	$C9CE  20 04 CA:      jsr _func_0A04
	$C9D1  A9 08:         lda #$08
	$C9D3  20 8E F4:      jsr _setLevelSoundData
	$C9D6  A9 1E:         lda #$1E
	$C9D8  20 F7 C9:      jsr _func_09F7
	$C9DB  20 1B C9:      jsr _queryKeyInput
	$C9DE  A9 00:         lda #$00
	$C9E0  85 A7:         sta $A7
	$C9E2  85 32:         sta $32
	$C9E4  20 8E F4:      jsr _setLevelSoundData
	$C9E7  A9 01:         lda #$01
	$C9E9  85 A6:         sta $A6
	$C9EB  68:           pla 
	$C9EC  AA:           tax 
	$C9ED  68:          pla 
	$C9EE  A8:          tay 
	$C9EF  4C 52 C9:    jmp ---		; $C952
;------------------------------------------
_data_09F2_indexed
	$C9F2               .byte $0E,$1C,$1E,$0A,$19
_func_09F7
	$C9F7  85 AC:       sta $AC
	$C9F9  20 01 CA:    jsr _func_0A01
	$C9FC  C6 AC:       dec $AC
	$C9FE  D0 01:       bne _func_0A01
	$CA00  60:          rts 
;------------------------------------------
_func_0A01
	$CA01  20 1B C9:    jsr _queryKeyInput
_func_0A04
	$CA04  20 06 C9:    jsr _func_0906
	$CA07  20 05 F5:    jsr _LevelSoundPlay
	$CA0A  A0 04:       ldy #$04
	$CA0C  A9 F0:       lda #$F0
-	$CA0E  99 00 02:    sta $0200,y
	$CA11  99 00 03:    sta $0300,y
	$CA14  C8:          iny 
	$CA15  D0 F7:       bne -		; $CA0E
	$CA17  A0 00:       ldy #$00
	$CA19  20 08 FF:    jsr _func_3F08
	$CA1C  20 08 FF:    jsr _func_3F08
	$CA1F  20 08 FF:    jsr _func_3F08
	$CA22  A5 4B:       lda $4B
	$CA24  0A:          asl a
	$CA25  A5 4A:       lda $4A
	$CA27  2A:          rol a
	$CA28  8D 05 20:    sta PPUSCROLL
	$CA2B  A9 00:       lda #$00
	$CA2D  8D 05 20:    sta PPUSCROLL
	$CA30  65 14:       adc ppuctrl_state
	$CA32  8D 00 20:    sta PPUCTRL
	$CA35  4C 14 FF:    jmp _func_3F14
;------------------------------------------
_func_0A38
	$CA38  A5 4F:       lda 程序及卡通定义页选择控制器
	$CA3A  29 01:       and #$01
	$CA3C  D0 68:       bne +++		; $CAA6
	$CA3E  A5 14:       lda ppuctrl_state
	$CA40  8D 00 20:    sta PPUCTRL
	$CA43  A9 20:       lda #$20
	$CA45  A0 71:       ldy #$71
	$CA47  20 64 E9:    jsr _func_2964
	$CA4A  A5 78:       lda $78
	$CA4C  D0 02:       bne +		; $CA50
	$CA4E  A9 2D:       lda #$2D
+	$CA50  8D 07 20:    sta PPUDATA
	$CA53  A5 77:       lda $77
	$CA55  8D 07 20:    sta PPUDATA
	$CA58  A9 00:       lda #$00
	$CA5A  85 38:       sta $38
	$CA5C  A9 20:       lda #$20
	$CA5E  A0 AE:       ldy #$AE
	$CA60  20 64 E9:    jsr _func_2964
	$CA63  A0 04:       ldy #$04
-	$CA65  B9 0F 00:    lda $000F,y
	$CA68  D0 08:       bne +		; $CA72
	$CA6A  A6 38:       ldx $38
	$CA6C  D0 06:       bne ++		; $CA74
	$CA6E  A9 2D:       lda #$2D
	$CA70  D0 02:       bne ++		; $CA74

+	$CA72  85 38:       sta $38
++	$CA74  8D 07 20:    sta PPUDATA
	$CA77  88:          dey 
	$CA78  10 EB:       bpl -		; $CA65
	$CA7A  A9 00:       lda #$00
	$CA7C  8D 07 20:    sta PPUDATA
	$CA7F  A5 14:       lda ppuctrl_state
	$CA81  09 04:       ora #$04
	$CA83  8D 00 20:    sta PPUCTRL
	$CA86  A4 48:       ldy $48
	$CA88  B9 A9 CB:    lda _DataPointerTableLo_0BA9,y
	$CA8B  85 22:       sta $22
	$CA8D  B9 B5 CB:    lda _DataPointerTableHi_0BA9,y
	$CA90  85 23:       sta $23
	$CA92  A9 21:       lda #$21
	$CA94  A0 FF:       ldy #$FF
	$CA96  20 64 E9:    jsr _func_2964
	$CA99  A0 00:       ldy #$00
-	$CA9B  B1 22:       lda ($22),y
	$CA9D  8D 07 20:    sta PPUDATA
	$CAA0  C8:          iny 
	$CAA1  C0 0F:       cpy #$0F
	$CAA3  90 F6:       bcc -		; $CA9B
	$CAA5  60:          rts 

+++	$CAA6  A5 14:       lda ppuctrl_state
	$CAA8  8D 00 20:    sta PPUCTRL
	$CAAB  A5 53:       lda $53
	$CAAD  4A:          lsr a
	$CAAE  4A:          lsr a
	$CAAF  4A:          lsr a
	$CAB0  C9 10:       cmp #$10
	$CAB2  90 02:       bcc +		; $CAB6
	$CAB4  A9 10:       lda #$10
+	$CAB6  85 17:       sta $17
	$CAB8  A9 20:       lda #$20
	$CABA  A0 A3:       ldy #$A3
	$CABC  20 64 E9:    jsr _func_2964
	$CABF  A5 17:       lda $17
	$CAC1  20 64 CB:    jsr _func_0B64
	$CAC4  0A:          asl a
	$CAC5  48:          pha 
	$CAC6  18:           clc 
	$CAC7  69 42:        adc #$42
	$CAC9  8D 07 20:     sta PPUDATA
	$CACC  A9 20:        lda #$20
	$CACE  A0 83:        ldy #$83
	$CAD0  20 64 E9:     jsr _func_2964
	$CAD3  68:          pla 
	$CAD4  18:          clc 
	$CAD5  69 41:       adc #$41
	$CAD7  8D 07 20:    sta PPUDATA
	$CADA  20 59 CB:    jsr _func_0B59
	$CADD  0A:          asl a
	$CADE  48:          pha 
	$CADF  18:           clc 
	$CAE0  69 42:        adc #$42
	$CAE2  8D 07 20:     sta PPUDATA
	$CAE5  A9 20:        lda #$20
	$CAE7  A0 64:        ldy #$64
	$CAE9  20 64 E9:     jsr _func_2964
	$CAEC  68:          pla 
	$CAED  18:          clc 
	$CAEE  69 41:       adc #$41
	$CAF0  8D 07 20:    sta PPUDATA
	$CAF3  A0 02:       ldy #$02
-	$CAF5  20 59 CB:    jsr _func_0B59
	$CAF8  18:          clc 
	$CAF9  69 47:       adc #$47
	$CAFB  8D 07 20:    sta PPUDATA
	$CAFE  88:          dey 
	$CAFF  10 F4:       bpl -		; $CAF5
	$CB01  A0 02:       ldy #$02
-	$CB03  20 59 CB:    jsr _func_0B59
	$CB06  18:          clc 
	$CB07  69 49:       adc #$49
	$CB09  C9 49:       cmp #$49
	$CB0B  D0 02:       bne +		; $CB0F
	$CB0D  A9 47:       lda #$47
+	$CB0F  8D 07 20:    sta PPUDATA
	$CB12  88:          dey 
	$CB13  10 EE:       bpl -		; $CB03
	$CB15  A5 14:       lda ppuctrl_state
	$CB17  09 04:       ora #$04
	$CB19  8D 00 20:    sta PPUCTRL
	$CB1C  A9 00:       lda #$00
	$CB1E  85 39:       sta $39
	$CB20  AA:          tax 
	$CB21  20 6B CB:    jsr _func_0B6B
	$CB24  E8:          inx 
	$CB25  20 6B CB:    jsr _func_0B6B
	$CB28  E6 39:       inc $39
	$CB2A  E8:          inx 
	$CB2B  20 6B CB:    jsr _func_0B6B
	$CB2E  A5 14:       lda ppuctrl_state
	$CB30  8D 00 20:    sta PPUCTRL
	$CB33  A5 47:       lda $47
	$CB35  0A:          asl a
	$CB36  0A:          asl a
	$CB37  18:          clc 
	$CB38  69 4C:       adc #$4C
	$CB3A  AA:          tax 
	$CB3B  A9 20:       lda #$20
	$CB3D  A0 6C:       ldy #$6C
	$CB3F  20 64 E9:    jsr _func_2964
	$CB42  8E 07 20:    stx PPUDATA
	$CB45  E8:          inx 
	$CB46  8E 07 20:    stx PPUDATA
	$CB49  A9 20:       lda #$20
	$CB4B  A0 8C:       ldy #$8C
	$CB4D  20 64 E9:    jsr _func_2964
	$CB50  E8:          inx 
	$CB51  8E 07 20:    stx PPUDATA
	$CB54  E8:          inx 
	$CB55  8E 07 20:    stx PPUDATA
	$CB58  60:          rts 
;------------------------------------------
_func_0B59
	$CB59  A5 17:       lda $17
	$CB5B  38:          sec 
	$CB5C  E9 02:       sbc #$02
	$CB5E  10 02:       bpl +		; $CB62
	$CB60  A9 00:       lda #$00
+	$CB62  85 17:       sta $17
_func_0B64
	$CB64  C9 02:       cmp #$02
	$CB66  90 02:       bcc +		; $CB6A -> rts
	$CB68  A9 02:       lda #$02
+	$CB6A  60:          rts 
;------------------------------------------
_func_0B6B
	$CB6B  A9 20:       lda #$20
	$CB6D  8D 06 20:    sta PPUADDR
	$CB70  8A:          txa 
	$CB71  18:          clc 
	$CB72  69 86:       adc #$86
	$CB74  8D 06 20:    sta PPUADDR
	$CB77  B5 61:       lda $61,x
	$CB79  D0 08:       bne +		; $CB83
	$CB7B  A4 39:       ldy $39
	$CB7D  D0 04:       bne +		; $CB83
	$CB7F  A9 0A:       lda #$0A
	$CB81  D0 02:       bne ++		; $CB85

+	$CB83  85 39:       sta $39
++	$CB85  A8:          tay 
	$CB86  B9 93 CB:    lda _data_0B93_indexed,y
	$CB89  8D 07 20:    sta PPUDATA
	$CB8C  B9 9E CB:    lda _data_0B9E_indexed,y
	$CB8F  8D 07 20:    sta PPUDATA
	$CB92  60:          rts 
;------------------------------------------
_data_0B93_indexed
	$CB93               .byte $39,$30,$31,$31,$34,$35,$35,$37,$38,$38,$2D
_data_0B9E_indexed
	$CB9E               .byte $36,$3A,$32,$33,$3A,$33,$36,$3A,$36,$33,$2D
_DataPointerTableLo_0BA9
	$CBA9  C1:          .byte < (DataTableEntry_0BC1)
	$CBAA  D0:          .byte < (DataTableEntry_0BD0)
	$CBAB  DF:          .byte < (DataTableEntry_0BDF)
	$CBAC  EE:          .byte < (DataTableEntry_0BEE)
	$CBAD  FD:          .byte < (DataTableEntry_0BFD)
	$CBAE  0C:          .byte < (DataTableEntry_0C0C)
	$CBAF               .byte $1B,$2A,$39,$48,$57,$66
_DataPointerTableHi_0BA9
	$CBB5  CB:          .byte > (DataTableEntry_0BC1)
	$CBB6  CB:          .byte > (DataTableEntry_0BD0)
	$CBB7  CB:          .byte > (DataTableEntry_0BDF)
	$CBB8  CB:          .byte > (DataTableEntry_0BEE)
	$CBB9  CB:          .byte > (DataTableEntry_0BFD)
	$CBBA  CC:          .byte > (DataTableEntry_0C0C)
	$CBBB               .byte $CC,$CC,$CC,$CC,$CC,$CC
DataTableEntry_0BC1
	$CBC1               .byte $61,$63,$68,$71,$77,$7F,$2C,$89,$8F,$92,$2C,$2C,$2C,$99,$92
DataTableEntry_0BD0
	$CBD0               .byte $61,$64,$69,$72,$78,$7F,$84,$8A,$8F,$92,$94,$2C,$2C,$2C,$9B
DataTableEntry_0BDF
	$CBDF               .byte $61,$65,$69,$73,$79,$7F,$85,$2C,$90,$92,$92,$2C,$2C,$2C,$2C
DataTableEntry_0BEE
	$CBEE               .byte $61,$65,$6A,$74,$7A,$7F,$86,$2C,$91,$92,$92,$94,$2C,$2C,$2C
DataTableEntry_0BFD
	$CBFD               .byte $62,$66,$6B,$77,$7B,$7F,$87,$2C,$2C,$92,$92,$92,$96,$2C,$2C
DataTableEntry_0C0C
	$CC0C               .byte $62,$66,$6B,$78,$7C,$80,$7F,$8B,$2C,$99,$92,$92,$97,$2C,$2C,$62
	$CC1C               .byte $67,$6C,$79,$69,$81
_data_0C21
	$CC21               .byte $7F,$8C,$2C,$2C,$92,$92,$92,$9A,$2C,$62,$67,$77,$7A,$72,$82,$7F
	$CC31               .byte $8D,$2C,$2C,$99,$92,$92,$92,$96,$62,$67,$6D,$75,$7D,$2C,$7F,$8F
	$CC41               .byte $8B,$2C,$2C,$92,$92,$92,$97,$62,$67,$6E,$7C,$7D,$84,$88,$8F,$8C
	$CC51               .byte $2C,$2C,$95,$92,$92,$92,$61,$63,$6F,$76,$7E,$85,$82,$8F,$8F,$2C
	$CC61               .byte $2C,$2C,$9B,$92,$92,$61,$63,$70,$69,$74,$83,$2C,$8E,$8F,$93,$2C
	$CC71               .byte $2C,$98,$92,$92
_func_0C75
	$CC75  A5 4F:       lda 程序及卡通定义页选择控制器
	$CC77  29 01:       and #$01
	$CC79  F0 01:       beq +		; $CC7C
	$CC7B  60:          rts 

+	$CC7C  20 82 CC:    jsr _func_0C82
	$CC7F  4C C8 FD:    jmp _loc_3DC8
;------------------------------------------
_func_0C82
	$CC82  A9 00:       lda #$00
	$CC84  85 5F:       sta $5F
	$CC86  85 60:       sta $60
	$CC88  A5 50:       lda $50
	$CC8A  D0 07:       bne +		; $CC93
	$CC8C  A5 51:       lda $51
	$CC8E  D0 03:       bne +		; $CC93
	$CC90  4C 72 CD:    jmp ++		; $CD72

+	$CC93  A5 50:       lda $50
	$CC95  85 17:       sta $17
	$CC97  A5 51:       lda $51
	$CC99  0A:          asl a
	$CC9A  26 17:       rol $17
	$CC9C  18:          clc 
	$CC9D  65 41:       adc $41
	$CC9F  85 41:       sta $41
	$CCA1  A5 42:       lda $42
	$CCA3  65 17:       adc $17
	$CCA5  85 42:       sta $42
	$CCA7  38:          sec 
	$CCA8  E5 45:       sbc $45
	$CCAA  85 60:       sta $60
	$CCAC  A5 42:       lda $42
	$CCAE  85 45:       sta $45
	$CCB0  A5 60:       lda $60
	$CCB2  F0 11:       beq +		; $CCC5
	$CCB4  18:          clc 
	$CCB5  65 40:       adc $40
	$CCB7  85 40:       sta $40
	$CCB9  C9 08:       cmp #$08
	$CCBB  90 08:       bcc +		; $CCC5
	$CCBD  E9 08:       sbc #$08
	$CCBF  85 40:       sta $40
	$CCC1  E6 5F:       inc $5F
	$CCC3  E6 43:       inc $43
+	$CCC5  A0 01:       ldy #$01
	$CCC7  B1 3C:       lda ($3C),y
	$CCC9  C5 43:       cmp $43
	$CCCB  90 03:       bcc +		; $CCD0
	$CCCD  4C 72 CD:    jmp ++		; $CD72

+ -	$CCD0  A9 00:       lda #$00
	$CCD2  85 43:       sta $43
	$CCD4  A5 3C:       lda $3C
	$CCD6  18:          clc 
	$CCD7  69 02:       adc #$02
	$CCD9  85 3C:       sta $3C
	$CCDB  90 02:       bcc +		; $CCDF
	$CCDD  E6 3D:       inc $3D
+	$CCDF  A0 00:       ldy #$00
	$CCE1  B1 3C:       lda ($3C),y
	$CCE3  C9 80:       cmp #$80
	$CCE5  D0 16:       bne +		; $CCFD
	$CCE7  E6 59:       inc $59
	$CCE9  A9 00:       lda #$00
	$CCEB  85 4A:       sta $4A
	$CCED  85 4B:       sta $4B
	$CCEF  A5 B3:       lda $B3
	$CCF1  C9 05:       cmp #$05
	$CCF3  90 DB:       bcc -		; $CCD0
	$CCF5  E6 5E:       inc $5E
	$CCF7  A9 01:       lda #$01
	$CCF9  85 59:       sta $59
	$CCFB  D0 D3:       bne -		; $CCD0

+	$CCFD  C8:          iny 
	$CCFE  B1 3C:       lda ($3C),y
	$CD00  D0 70:       bne ++		; $CD72
	$CD02  A9 60:       lda #$60
	$CD04  85 3C:       sta $3C
	$CD06  A9 06:       lda #$06
	$CD08  85 3D:       sta $3D
	$CD0A  A9 00:       lda #$00
	$CD0C  85 66:       sta $66
	$CD0E  A9 07:       lda #$07
	$CD10  85 67:       sta $67
	$CD12  A9 00:       lda #$00
	$CD14  85 74:       sta $74
	$CD16  85 43:       sta $43
	$CD18  85 44:       sta $44
	$CD1A  85 40:       sta $40
	$CD1C  85 45:       sta $45
	$CD1E  85 46:       sta $46
	$CD20  85 41:       sta $41
	$CD22  85 42:       sta $42
	$CD24  20 B4 C7:    jsr _func_07B4
	$CD27  A5 59:       lda $59
	$CD29  C9 02:       cmp #$02
	$CD2B  90 04:       bcc +		; $CD31
	$CD2D  85 5B:       sta $5B
	$CD2F  B0 41:       bcs ++		; $CD72
+	$CD31  A4 2D:       ldy $2D
	$CD33  B9 74 F0:    lda _DataPointerTableLo_3074,y
	$CD36  85 17:       sta $17
	$CD38  B9 7E F0:    lda _DataPointerTableHi_3074,y
	$CD3B  85 18:       sta $18
	$CD3D  A5 5E:       lda $5E
	$CD3F  0A:          asl a
	$CD40  0A:          asl a
	$CD41  85 19:       sta $19
	$CD43  A5 17:       lda $17
	$CD45  38:          sec 
	$CD46  E5 19:       sbc $19
-	$CD48  85 17:       sta $17
	$CD4A  10 08:       bpl +		; $CD54
	$CD4C  C6 18:       dec $18
	$CD4E  18:          clc 
	$CD4F  69 0A:       adc #$0A
	$CD51  4C 48 CD:    jmp -		; $CD48

+	$CD54  A5 18:       lda $18
	$CD56  10 06:       bpl +		; $CD5E
	$CD58  A9 00:       lda #$00
	$CD5A  85 17:       sta $17
	$CD5C  85 18:       sta $18
+	$CD5E  A5 77:       lda $77
	$CD60  18:          clc 
	$CD61  65 17:       adc $17
	$CD63  C9 0A:       cmp #$0A
	$CD65  90 03:       bcc +		; $CD6A
	$CD67  E9 0A:       sbc #$0A
	$CD69  38:          sec 
+	$CD6A  85 77:       sta $77
	$CD6C  A5 78:       lda $78
	$CD6E  65 18:       adc $18
	$CD70  85 78:       sta $78
++	$CD72  A9 00:       lda #$00
	$CD74  85 18:       sta $18
	$CD76  85 19:       sta $19
	$CD78  85 1A:       sta $1A
	$CD7A  85 1B:       sta $1B
	$CD7C  A9 14:       lda #$14
	$CD7E  85 1C:       sta $1C
	$CD80  A9 80:       lda #$80
	$CD82  85 17:       sta $17
	$CD84  A5 3C:       lda $3C
	$CD86  85 3E:       sta $3E
	$CD88  A5 3D:       lda $3D
	$CD8A  85 3F:       sta $3F
	$CD8C  A5 43:       lda $43
	$CD8E  85 64:       sta $64
	$CD90  A2 7F:       ldx #$7F
--	$CD92  A5 18:       lda $18
	$CD94  9D 00 05:    sta $0500,x
	$CD97  A5 17:       lda $17
	$CD99  18:          clc 
	$CD9A  65 19:       adc $19
	$CD9C  85 17:       sta $17
	$CD9E  A5 18:       lda $18
	$CDA0  65 1A:       adc $1A
	$CDA2  85 18:       sta $18
	$CDA4  E6 1B:       inc $1B
	$CDA6  A5 1C:       lda $1C
	$CDA8  30 05:       bmi +		; $CDAF
	$CDAA  4A:          lsr a
	$CDAB  C5 1B:       cmp $1B
	$CDAD  B0 47:       bcs ++		; $CDF6
+	$CDAF  A9 00:       lda #$00
	$CDB1  85 1B:       sta $1B
	$CDB3  C6 1C:       dec $1C
	$CDB5  A0 00:       ldy #$00
	$CDB7  84 1D:       sty $1D
	$CDB9  B1 3E:       lda ($3E),y
	$CDBB  10 02:       bpl +		; $CDBF
	$CDBD  C6 1D:       dec $1D
+	$CDBF  18:          clc 
	$CDC0  65 19:       adc $19
	$CDC2  85 19:       sta $19
	$CDC4  A5 1A:       lda $1A
	$CDC6  65 1D:       adc $1D
	$CDC8  85 1A:       sta $1A
	$CDCA  E6 64:       inc $64
	$CDCC  C8:          iny 
	$CDCD  B1 3E:       lda ($3E),y
	$CDCF  C5 64:       cmp $64
	$CDD1  B0 23:       bcs ++		; $CDF6
-	$CDD3  A9 00:       lda #$00
	$CDD5  85 64:       sta $64
	$CDD7  A5 3E:       lda $3E
	$CDD9  18:          clc 
	$CDDA  69 02:       adc #$02
	$CDDC  85 3E:       sta $3E
	$CDDE  90 02:       bcc +		; $CDE2
	$CDE0  E6 3F:       inc $3F
+	$CDE2  88:          dey 
	$CDE3  B1 3E:       lda ($3E),y
	$CDE5  C9 80:       cmp #$80
	$CDE7  F0 EA:       beq -		; $CDD3
	$CDE9  C8:          iny 
	$CDEA  B1 3E:       lda ($3E),y
	$CDEC  D0 08:       bne ++		; $CDF6
	$CDEE  A9 60:       lda #$60
	$CDF0  85 3E:       sta $3E
	$CDF2  A9 06:       lda #$06
	$CDF4  85 3F:       sta $3F
++	$CDF6  CA:          dex 
	$CDF7  10 99:       bpl --		; $CD92
	$CDF9  A5 5F:       lda $5F
	$CDFB  F0 36:       beq ++		; $CE33
	$CDFD  A0 00:       ldy #$00
	$CDFF  84 17:       sty $17
	$CE01  B1 3C:       lda ($3C),y
	$CE03  10 07:       bpl +		; $CE0C
	$CE05  E6 17:       inc $17
	$CE07  49 FF:       eor #$FF
	$CE09  18:          clc 
	$CE0A  69 01:       adc #$01
+	$CE0C  85 9F:       sta $9F
	$CE0E  A9 20:       lda #$20
	$CE10  85 A1:       sta $A1
	$CE12  20 97 E9:    jsr _func_2997
	$CE15  A5 17:       lda $17
	$CE17  F0 0D:       beq +		; $CE26
	$CE19  A9 00:       lda #$00
	$CE1B  38:          sec 
	$CE1C  E5 A2:       sbc $A2
	$CE1E  85 A2:       sta $A2
	$CE20  A9 00:       lda #$00
	$CE22  E5 A3:       sbc $A3
	$CE24  85 A3:       sta $A3
+	$CE26  A5 A2:       lda $A2
	$CE28  18:          clc 
	$CE29  65 4B:       adc $4B
	$CE2B  85 4B:       sta $4B
	$CE2D  A5 4A:       lda $4A
	$CE2F  65 A3:       adc $A3
	$CE31  85 4A:       sta $4A
++	$CE33  20 08 C2:    jsr _func_0208
	$CE36  4C DE E1:    jmp _loc_21DE

---	$CE39  A9 00:       lda #$00
	$CE3B  85 74:       sta $74
	$CE3D  4C 7E C1:    jmp _loc_017E

--	$CE40  A9 00:       lda #$00
	$CE42  85 74:       sta $74
	$CE44  4C 6C CF:    jmp _loc_0F6C
;------------------------------------------
_loc_0E47
	$CE47  A9 08:       lda #$08
	$CE49  85 A4:       sta $A4
-	$CE4B  20 1B C9:    jsr _queryKeyInput
	$CE4E  20 38 CA:    jsr _func_0A38
	$CE51  20 06 C9:    jsr _func_0906
	$CE54  84 6D:       sty $6D
	$CE56  C8:          iny 
	$CE57  84 6E:       sty $6E
	$CE59  A0 40:       ldy #$40
	$CE5B  20 08 FF:    jsr _func_3F08
	$CE5E  E6 4F:       inc 程序及卡通定义页选择控制器
	$CE60  20 75 CC:    jsr _func_0C75
	$CE63  20 1B D1:    jsr _func_111B
	$CE66  20 14 FF:    jsr _func_3F14
	$CE69  A5 56:       lda $56
	$CE6B  C9 60:       cmp #$60
	$CE6D  90 0B:       bcc +		; $CE7A
	$CE6F  20 FC C1:    jsr _func_01FC
	$CE72  A9 0B:       lda #$0B
	$CE74  85 7C:       sta $7C
	$CE76  A9 FA:       lda #$FA
	$CE78  85 9E:       sta $9E
+	$CE7A  A5 5B:       lda $5B
	$CE7C  F0 03:       beq +		; $CE81
	$CE7E  4C 6C CF:    jmp _loc_0F6C

+	$CE81  A5 77:       lda $77
	$CE83  D0 B4:       bne ---		; $CE39
	$CE85  A5 78:       lda $78
	$CE87  D0 B0:       bne ---		; $CE39
	$CE89  A5 5A:       lda $5A
	$CE8B  D0 B3:       bne --		; $CE40
	$CE8D  A5 50:       lda $50
	$CE8F  D0 BA:       bne -		; $CE4B
	$CE91  A5 51:       lda $51
	$CE93  D0 B6:       bne -		; $CE4B
	$CE95  A5 8F:       lda $8F
	$CE97  C9 F0:       cmp #$F0
	$CE99  90 B0:       bcc -		; $CE4B
	$CE9B  A5 90:       lda $90
	$CE9D  C9 F0:       cmp #$F0
	$CE9F  90 AA:       bcc -		; $CE4B
	$CEA1  A5 91:       lda $91
	$CEA3  C9 F0:       cmp #$F0
	$CEA5  90 A4:       bcc -		; $CE4B
	$CEA7  A5 56:       lda $56
	$CEA9  D0 A0:       bne -		; $CE4B
	$CEAB  C6 A4:       dec $A4
	$CEAD  10 9C:       bpl -		; $CE4B
	$CEAF  A9 00:       lda #$00
	$CEB1  85 34:       sta $34
	$CEB3  85 61:       sta $61
	$CEB5  85 62:       sta $62
	$CEB7  85 63:       sta $63
	$CEB9  A9 01:       lda #$01
	$CEBB  85 A7:       sta $A7
	$CEBD  20 1B C9:    jsr _queryKeyInput
	$CEC0  A9 23:       lda #$23
	$CEC2  A0 D2:       ldy #$D2
	$CEC4  20 64 E9:    jsr _func_2964
	$CEC7  A9 FF:       lda #$FF
	$CEC9  20 FB D0:    jsr _func_10FB
	$CECC  A9 21:       lda #$21
	$CECE  A0 2A:       ldy #$2A
	$CED0  20 64 E9:    jsr _func_2964
	$CED3  A0 0B:       ldy #$0B
-	$CED5  B9 5D CF:    lda _data_0F5D_indexed,y
	$CED8  8D 07 20:    sta PPUDATA
	$CEDB  88:          dey 
	$CEDC  10 F7:       bpl -		; $CED5
	$CEDE  A9 21:       lda #$21
	$CEE0  A0 49:       ldy #$49
	$CEE2  20 64 E9:    jsr _func_2964
	$CEE5  A9 2D:       lda #$2D
	$CEE7  A0 0E:       ldy #$0E
-	$CEE9  8D 07 20:    sta PPUDATA
	$CEEC  88:          dey 
	$CEED  10 FA:       bpl -		; $CEE9
	$CEEF  A9 21:       lda #$21
	$CEF1  A0 68:       ldy #$68
	$CEF3  20 64 E9:    jsr _func_2964
	$CEF6  A0 0F:       ldy #$0F
	$CEF8  A9 2D:       lda #$2D
-	$CEFA  8D 07 20:    sta PPUDATA
	$CEFD  88:          dey 
	$CEFE  10 FA:       bpl -		; $CEFA
	$CF00  20 06 C9:    jsr _func_0906
	$CF03  20 08 FF:    jsr _func_3F08
	$CF06  A9 02:       lda #$02
	$CF08  20 8E F4:    jsr _setLevelSoundData
	$CF0B  20 14 FF:    jsr _func_3F14
	$CF0E  A5 C6:       lda $C6
	$CF10  8D 04 02:    sta $0204
	$CF13  8D 04 03:    sta $0304
	$CF16  A9 FC:       lda #$FC
	$CF18  8D 05 02:    sta $0205
	$CF1B  8D 05 03:    sta $0305
	$CF1E  A9 00:       lda #$00
	$CF20  8D 06 02:    sta $0206
	$CF23  8D 06 03:    sta $0306
	$CF26  A5 C4:       lda $C4
	$CF28  8D 07 02:    sta $0207
	$CF2B  8D 07 03:    sta $0307
	$CF2E  A5 71:       lda 游戏演示标志
	$CF30  D0 23:       bne +		; $CF55
	$CF32  85 36:       sta $36
	$CF34  85 37:       sta $37
	$CF36  A9 02:       lda #$02
	$CF38  85 71:       sta 游戏演示标志
-	$CF3A  20 1B C9:    jsr _queryKeyInput
	$CF3D  20 38 CA:    jsr _func_0A38
	$CF40  20 06 C9:    jsr _func_0906
	$CF43  20 08 FF:    jsr _func_3F08
	$CF46  20 14 FF:    jsr _func_3F14
	$CF49  A5 B8:       lda $B8
	$CF4B  10 ED:       bpl -		; $CF3A
	$CF4D  A9 14:       lda #$14
	$CF4F  20 D4 D0:    jsr _func_10D4
	$CF52  4C 0A E6:    jmp _main_reset_code

+	$CF55  A9 3C:       lda #$3C
	$CF57  20 D4 D0:    jsr _func_10D4
	$CF5A  4C 0A E6:    jmp _main_reset_code
;------------------------------------------
_data_0F5D_indexed
	$CF5D               .byte $2D,$1B,$0E,$1F,$18,$2D,$2D,$0E,$16,$0A,$10,$2D
_data_0F69_indexed
	$CF69               .byte $00,$05,$0A
_loc_0F6C
	$CF6C  A5 50:       lda $50
	$CF6E  85 B6:       sta $B6
	$CF70  A5 51:       lda $51
	$CF72  85 B7:       sta $B7
	$CF74  20 AC F3:    jsr _func_33AC
	$CF77  85 56:       sta $56
	$CF79  85 B5:       sta $B5
	$CF7B  85 34:       sta $34
	$CF7D  A9 0A:       lda #$0A
	$CF7F  85 5A:       sta $5A
	$CF81  85 A4:       sta $A4
-	$CF83  20 1B C9:    jsr _queryKeyInput
	$CF86  20 38 CA:    jsr _func_0A38
	$CF89  20 06 C9:    jsr _func_0906
	$CF8C  20 57 E9:    jsr _func_2957
	$CF8F  20 75 CC:    jsr _func_0C75
	$CF92  20 1B D1:    jsr _func_111B
	$CF95  E6 4F:       inc 程序及卡通定义页选择控制器
	$CF97  A9 FF:       lda #$FF
	$CF99  20 8E F4:    jsr _setLevelSoundData
	$CF9C  20 14 FF:    jsr _func_3F14
	$CF9F  A5 B4:       lda $B4
	$CFA1  C9 F0:       cmp #$F0
	$CFA3  90 DE:       bcc -		; $CF83
	$CFA5  A5 8F:       lda $8F
	$CFA7  C9 F0:       cmp #$F0
	$CFA9  90 D8:       bcc -		; $CF83
	$CFAB  A5 90:       lda $90
	$CFAD  C9 F0:       cmp #$F0
	$CFAF  90 D2:       bcc -		; $CF83
	$CFB1  A5 91:       lda $91
	$CFB3  C9 F0:       cmp #$F0
	$CFB5  90 CC:       bcc -		; $CF83
	$CFB7  C6 A4:       dec $A4
	$CFB9  D0 C8:       bne -		; $CF83
	$CFBB  E6 34:       inc $34
	$CFBD  A9 00:       lda #$00
	$CFBF  85 4F:       sta 程序及卡通定义页选择控制器
	$CFC1  A9 FF:       lda #$FF
	$CFC3  20 8E F4:    jsr _setLevelSoundData
	$CFC6  A9 5A:       lda #$5A
	$CFC8  20 D4 D0:    jsr _func_10D4
	$CFCB  E6 2D:       inc $2D
	$CFCD  E6 B3:       inc $B3
	$CFCF  4C 3A C1:    jmp _loc_013A
;------------------------------------------
_func_0FD2
	$CFD2  A9 01:       lda #$01
	$CFD4  85 A7:       sta $A7
	$CFD6  20 6E F3:    jsr _cleanNT_OAM
	$CFD9  20 1B C9:    jsr _queryKeyInput
	$CFDC  A9 21:       lda #$21
	$CFDE  85 22:       sta $22
	$CFE0  A9 06:       lda #$06
	$CFE2  85 23:       sta $23
	$CFE4  A2 0D:       ldx #$0D
--	$CFE6  A5 22:       lda $22
	$CFE8  8D 06 20:    sta PPUADDR
	$CFEB  A5 23:       lda $23
	$CFED  8D 06 20:    sta PPUADDR
	$CFF0  A9 9F:       lda #$9F
	$CFF2  A0 13:       ldy #$13
-	$CFF4  8D 07 20:    sta PPUDATA
	$CFF7  88:          dey 
	$CFF8  10 FA:       bpl -		; $CFF4
	$CFFA  A5 23:       lda $23
	$CFFC  18:          clc 
	$CFFD  69 20:       adc #$20
	$CFFF  85 23:       sta $23
DataTableEntry_1001
	$D001  90 02:       bcc _loc_1005
	$D003  E6 22:       inc $22
_loc_1005
	$D005  CA:          dex 
	$D006  10 DE:       bpl --		; $CFE6
	$D008  A9 21:       lda #$21
	$D00A  85 22:       sta $22
	$D00C  A9 69:       lda #$69
	$D00E  85 23:       sta $23
	$D010  A2 07:       ldx #$07
--	$D012  A5 22:       lda $22
	$D014  8D 06 20:    sta PPUADDR
	$D017  A5 23:       lda $23
	$D019  8D 06 20:    sta PPUADDR
	$D01C  A9 2D:       lda #$2D
	$D01E  A0 0D:       ldy #$0D
-	$D020  8D 07 20:    sta PPUDATA
	$D023  88:          dey 
	$D024  10 FA:       bpl -		; $D020
	$D026  A5 23:       lda $23
	$D028  18:          clc 
	$D029  69 20:       adc #$20
	$D02B  85 23:       sta $23
	$D02D  90 02:       bcc +		; $D031
	$D02F  E6 22:       inc $22
+	$D031  CA:          dex 
	$D032  10 DE:       bpl --		; $D012
	$D034  20 1B C9:    jsr _queryKeyInput
	$D037  A9 3F:       lda #$3F
	$D039  A0 00:       ldy #$00
	$D03B  20 64 E9:    jsr _func_2964
	$D03E  A9 0F:       lda #$0F
	$D040  20 01 D1:    jsr _func_1101
	$D043  A9 2A:       lda #$2A
	$D045  20 01 D1:    jsr _func_1101
	$D048  A9 0F:       lda #$0F
	$D04A  20 FE D0:    jsr _func_10FE
	$D04D  A9 30:       lda #$30
	$D04F  8D 07 20:    sta PPUDATA
	$D052  A9 0F:       lda #$0F
	$D054  20 01 D1:    jsr _func_1101
	$D057  A9 26:       lda #$26
	$D059  8D 07 20:    sta PPUDATA
	$D05C  A9 2C:       lda #$2C
	$D05E  8D 07 20:    sta PPUDATA
	$D061  A9 21:       lda #<_data_0C21
	$D063  85 17:       sta $17
	$D065  A9 8C:       lda #>_data_0C21
	$D067  85 18:       sta $18
	$D069  20 9D F0:    jsr _func_309D
	$D06C  A9 23:       lda #$23
	$D06E  A0 C0:       ldy #$C0
	$D070  20 64 E9:    jsr _func_2964
	$D073  A0 3F:       ldy #$3F
	$D075  A9 55:       lda #$55
-	$D077  8D 07 20:    sta PPUDATA
	$D07A  88:          dey 
	$D07B  10 FA:       bpl -		; $D077
	$D07D  A9 23:       lda #$23
	$D07F  A0 DB:       ldy #$DB
	$D081  20 64 E9:    jsr _func_2964
	$D084  A9 AA:       lda #$AA
	$D086  20 01 D1:    jsr _func_1101
	$D089  A9 EE:       lda #$EE
	$D08B  8D 07 20:    sta PPUDATA
	$D08E  A9 23:       lda #$23
	$D090  A0 E2:       ldy #$E2
	$D092  20 64 E9:    jsr _func_2964
	$D095  A9 53:       lda #$53
	$D097  8D 07 20:    sta PPUDATA
	$D09A  A9 50:       lda #$50
	$D09C  20 01 D1:    jsr _func_1101
	$D09F  A9 5C:       lda #$5C
	$D0A1  8D 07 20:    sta PPUDATA
	$D0A4  A9 22:       lda #$22
	$D0A6  A0 2A:       ldy #$2A
	$D0A8  20 64 E9:    jsr _func_2964
	$D0AB  A0 0A:       ldy #$0A
-	$D0AD  B9 EA D0:    lda _data_10EA_indexed,y
	$D0B0  8D 07 20:    sta PPUDATA
	$D0B3  88:          dey 
	$D0B4  10 F7:       bpl -		; $D0AD
	$D0B6  A5 B3:       lda $B3
	$D0B8  8D 07 20:    sta PPUDATA
	$D0BB  20 06 C9:    jsr _func_0906
	$D0BE  20 6E F4:    jsr _soundPrepare
	$D0C1  A9 01:       lda #$01
	$D0C3  20 8E F4:    jsr _setLevelSoundData
	$D0C6  20 05 F5:    jsr _LevelSoundPlay
-	$D0C9  20 1B C9:    jsr _queryKeyInput
	$D0CC  20 05 F5:    jsr _LevelSoundPlay
	$D0CF  A5 B8:       lda $B8
	$D0D1  10 F6:       bpl -		; $D0C9
	$D0D3  60:          rts 
;------------------------------------------
_func_10D4
	$D0D4  85 A4:       sta $A4
-	$D0D6  20 1B C9:    jsr _queryKeyInput
	$D0D9  20 38 CA:    jsr _func_0A38
	$D0DC  20 06 C9:    jsr _func_0906
	$D0DF  20 08 FF:    jsr _func_3F08
	$D0E2  20 14 FF:    jsr _func_3F14
	$D0E5  C6 A4:       dec $A4
	$D0E7  D0 ED:       bne -		; $D0D6
	$D0E9  60:          rts 
;------------------------------------------
_data_10EA_indexed
	$D0EA               .byte $27,$3C,$17,$2D,$1D,$12,$1E,$0C,$1B,$12,$0C
_func_10F5
	$D0F5  8D 07 20:    sta PPUDATA
	$D0F8  8D 07 20:    sta PPUDATA
_func_10FB
	$D0FB  8D 07 20:    sta PPUDATA
_func_10FE
	$D0FE  8D 07 20:    sta PPUDATA
_func_1101
	$D101  8D 07 20:    sta PPUDATA
	$D104  8D 07 20:    sta PPUDATA
	$D107  60:          rts 
;------------------------------------------
_func_1108
	$D108  9D 00 02:    sta $0200,x
	$D10B  9D 00 03:    sta $0300,x
	$D10E  9D 04 02:    sta $0204,x
	$D111  9D 04 03:    sta $0304,x
	$D114  60:          rts 
;------------------------------------------
_data_1115_indexed
	$D115               .byte $64,$0A,$01
_data_1118_indexed
	$D118               .byte $00,$00,$00
_func_111B
	$D11B  A5 4F:       lda 程序及卡通定义页选择控制器
	$D11D  29 01:       and #$01
	$D11F  D0 01:       bne +		; $D122
	$D121  60:          rts 

+	$D122  A5 71:       lda 游戏演示标志
	$D124  D0 27:       bne +		; $D14D
	$D126  A5 5A:       lda $5A
	$D128  D0 23:       bne +		; $D14D
	$D12A  E6 76:       inc $76
	$D12C  A5 76:       lda $76
	$D12E  C9 1E:       cmp #$1E
	$D130  90 1B:       bcc +		; $D14D
	$D132  A9 00:       lda #$00
	$D134  85 76:       sta $76
	$D136  C6 77:       dec $77
	$D138  10 13:       bpl +		; $D14D
	$D13A  A9 09:       lda #$09
	$D13C  85 77:       sta $77
	$D13E  C6 78:       dec $78
	$D140  10 0B:       bpl +		; $D14D
	$D142  A0 00:       ldy #$00
	$D144  84 76:       sty $76
	$D146  84 77:       sty $77
	$D148  84 78:       sty $78
	$D14A  C8:          iny 
	$D14B  84 74:       sty $74
+	$D14D  A5 5A:       lda $5A
	$D14F  D0 3B:       bne ++		; $D18C
	$D151  A9 00:       lda #$00
	$D153  85 61:       sta $61
	$D155  85 62:       sta $62
	$D157  85 63:       sta $63
	$D159  AA:          tax 
	$D15A  A5 50:       lda $50
	$D15C  85 17:       sta $17
	$D15E  A5 51:       lda $51
	$D160  85 18:       sta $18
-	$D162  A5 18:       lda $18
	$D164  38:          sec 
	$D165  FD 15 D1:    sbc _data_1115_indexed,x
	$D168  85 18:       sta $18
	$D16A  A5 17:       lda $17
	$D16C  FD 18 D1:    sbc _data_1118_indexed,x
	$D16F  85 17:       sta $17
	$D171  90 05:       bcc +		; $D178
	$D173  F6 61:       inc $61,x
	$D175  4C 62 D1:    jmp -		; $D162

+	$D178  A5 18:       lda $18
	$D17A  18:          clc 
	$D17B  7D 15 D1:    adc _data_1115_indexed,x
	$D17E  85 18:       sta $18
	$D180  A5 17:       lda $17
	$D182  7D 18 D1:    adc _data_1118_indexed,x
	$D185  85 17:       sta $17
	$D187  E8:          inx 
	$D188  E0 03:       cpx #$03
	$D18A  90 D6:       bcc -		; $D162
++	$D18C  A5 50:       lda $50
	$D18E  85 65:       sta $65
	$D190  A5 51:       lda $51
	$D192  0A:          asl a
	$D193  26 65:       rol $65
	$D195  0A:          asl a
	$D196  26 65:       rol $65
	$D198  18:          clc 
	$D199  65 49:       adc $49
	$D19B  85 49:       sta $49
	$D19D  A5 65:       lda $65
	$D19F  65 48:       adc $48
	$D1A1  C9 0C:       cmp #$0C
	$D1A3  90 03:       bcc +		; $D1A8
	$D1A5  38:          sec 
	$D1A6  E9 0C:       sbc #$0C
+	$D1A8  85 48:       sta $48
	$D1AA  A5 6F:       lda $6F
	$D1AC  30 04:       bmi +		; $D1B2
	$D1AE  49 01:       eor #$01
	$D1B0  85 47:       sta $47
+	$D1B2  A5 56:       lda $56
	$D1B4  05 5A:       ora $5A
	$D1B6  D0 41:       bne ++		; $D1F9
	$D1B8  A5 50:       lda $50
	$D1BA  4A:          lsr a
	$D1BB  A5 51:       lda $51
	$D1BD  6A:          ror a
	$D1BE  A4 47:       ldy $47
	$D1C0  F0 01:       beq +		; $D1C3
	$D1C2  4A:          lsr a
+	$D1C3  85 53:       sta $53
	$D1C5  A9 00:       lda #$00
	$D1C7  85 5C:       sta $5C
	$D1C9  A5 7A:       lda $7A
	$D1CB  F0 2C:       beq ++		; $D1F9
	$D1CD  C6 7A:       dec $7A
	$D1CF  A9 04:       lda #$04
	$D1D1  85 5C:       sta $5C
	$D1D3  20 8E F4:    jsr _setLevelSoundData
	$D1D6  A9 04:       lda #$04
	$D1D8  A4 47:       ldy $47
	$D1DA  F0 02:       beq +		; $D1DE
	$D1DC  A9 03:       lda #$03
+	$D1DE  85 17:       sta $17
	$D1E0  A5 51:       lda $51
	$D1E2  18:          clc 
	$D1E3  65 17:       adc $17
	$D1E5  85 51:       sta $51
	$D1E7  A5 50:       lda $50
	$D1E9  69 00:       adc #$00
	$D1EB  85 50:       sta $50
	$D1ED  A5 7A:       lda $7A
	$D1EF  C5 53:       cmp $53
	$D1F1  85 53:       sta $53
	$D1F3  B0 04:       bcs ++		; $D1F9
	$D1F5  A9 00:       lda #$00
	$D1F7  85 7A:       sta $7A
++	$D1F9  A5 79:       lda $79
	$D1FB  49 07:       eor #$07
	$D1FD  85 79:       sta $79
	$D1FF  A5 71:       lda 游戏演示标志
	$D201  D0 42:       bne ++		; $D245
	$D203  A5 5F:       lda $5F
	$D205  F0 15:       beq +		; $D21C
	$D207  E6 0F:       inc $0F
	$D209  A2 00:       ldx #$00
-	$D20B  B5 0F:       lda $0F,x
	$D20D  C9 0A:       cmp #$0A
	$D20F  90 0B:       bcc +		; $D21C
	$D211  A9 00:       lda #$00
	$D213  95 0F:       sta $0F,x
	$D215  F6 10:       inc $10,x
	$D217  E8:          inx 
	$D218  E0 05:       cpx #$05
	$D21A  90 EF:       bcc -		; $D20B
+	$D21C  A4 33:       ldy $33
	$D21E  BE 69 CF:    ldx _data_0F69_indexed,y
	$D221  A5 0F:       lda $0F
	$D223  38:          sec 
	$D224  F5 00:       sbc $00,x
	$D226  A5 10:       lda $10
	$D228  F5 01:       sbc $01,x
	$D22A  A5 11:       lda $11
	$D22C  F5 02:       sbc $02,x
	$D22E  A5 12:       lda $12
	$D230  F5 03:       sbc $03,x
	$D232  A5 13:       lda $13
	$D234  F5 04:       sbc $04,x
	$D236  90 0D:       bcc ++		; $D245
	$D238  A0 00:       ldy #$00
-	$D23A  B9 0F 00:    lda $000F,y
	$D23D  95 00:       sta $00,x
	$D23F  E8:          inx 
	$D240  C8:          iny 
	$D241  C0 05:       cpy #$05
	$D243  90 F5:       bcc -		; $D23A
++	$D245  A5 5A:       lda $5A
	$D247  D0 69:       bne _loc_12B2
	$D249  A9 00:       lda #$00
	$D24B  85 C3:       sta $C3
	$D24D  A5 4D:       lda $4D
	$D24F  D0 08:       bne +		; $D259
	$D251  A5 4C:       lda $4C
	$D253  C9 62:       cmp #$62
	$D255  90 5B:       bcc _loc_12B2
	$D257  B0 06:       bcs ++		; $D25F
+	$D259  A5 4C:       lda $4C
	$D25B  C9 A2:       cmp #$A2
	$D25D  B0 53:       bcs _loc_12B2
++	$D25F  E6 C3:       inc $C3
	$D261  A5 53:       lda $53
	$D263  C9 44:       cmp #$44
	$D265  B0 39:       bcs +++		; $D2A0
	$D267  A4 A5:       ldy $A5
	$D269  A5 47:       lda $47
	$D26B  D0 0F:       bne +		; $D27C
	$D26D  B9 7D C4:    lda _data_047D_indexed,y
	$D270  85 17:       sta $17
	$D272  B9 3D C4:    lda _data_043D_indexed,y
	$D275  38:          sec 
	$D276  F9 1D C4:    sbc _data_041D_indexed,y
	$D279  4C 87 D2:    jmp ++		; $D287

+	$D27C  B9 FD C4:    lda _DataPointerTableHi_04BD,y
	$D27F  85 17:       sta $17
	$D281  B9 BD C4:    lda _DataPointerTableLo_04BD,y
	$D284  38:          sec 
	$D285  E9 01:       sbc #$01
++	$D287  85 18:       sta $18
	$D289  A5 52:       lda $52
	$D28B  38:          sec 
	$D28C  E5 17:       sbc $17
	$D28E  85 52:       sta $52
	$D290  A5 51:       lda $51
	$D292  E5 18:       sbc $18
	$D294  85 51:       sta $51
	$D296  A5 50:       lda $50
	$D298  E9 00:       sbc #$00
	$D29A  85 50:       sta $50
	$D29C  10 14:       bpl _loc_12B2
	$D29E  30 0F:       bmi ++++		; $D2AF
+++	$D2A0  A5 51:       lda $51
	$D2A2  38:          sec 
	$D2A3  E9 03:       sbc #$03
	$D2A5  85 51:       sta $51
	$D2A7  A5 50:       lda $50
	$D2A9  E9 00:       sbc #$00
	$D2AB  85 50:       sta $50
	$D2AD  10 03:       bpl _loc_12B2
++++	$D2AF  20 AC F3:    jsr _func_33AC
_loc_12B2
	$D2B2  A5 50:       lda $50
	$D2B4  F0 0A:       beq +		; $D2C0
	$D2B6  A5 51:       lda $51
	$D2B8  C9 A0:       cmp #$A0
	$D2BA  90 04:       bcc +		; $D2C0
	$D2BC  A9 01:       lda #$01
	$D2BE  85 75:       sta $75
+	$D2C0  A5 56:       lda $56
	$D2C2  F0 03:       beq +		; $D2C7
	$D2C4  4C 54 F2:    jmp _loc_3254

+	$D2C7  A5 5A:       lda $5A
	$D2C9  F0 03:       beq +		; $D2CE
	$D2CB  4C B5 F3:    jmp _loc_33B5

+	$D2CE  A9 0B:       lda #$0B
	$D2D0  A4 70:       ldy $70
	$D2D2  30 16:       bmi ++		; $D2EA
	$D2D4  F0 0A:       beq +		; $D2E0
	$D2D6  C6 7C:       dec $7C
	$D2D8  A5 7C:       lda $7C
	$D2DA  10 0E:       bpl ++		; $D2EA
	$D2DC  A9 00:       lda #$00
	$D2DE  F0 0A:       beq ++		; $D2EA

+	$D2E0  E6 7C:       inc $7C
	$D2E2  A5 7C:       lda $7C
	$D2E4  C9 16:       cmp #$16
	$D2E6  90 02:       bcc ++		; $D2EA
	$D2E8  A9 16:       lda #$16
++	$D2EA  85 7C:       sta $7C
	$D2EC  A5 50:       lda $50
	$D2EE  4A:          lsr a
	$D2EF  A5 51:       lda $51
	$D2F1  6A:          ror a
	$D2F2  18:          clc 
	$D2F3  65 55:       adc $55
	$D2F5  85 55:       sta $55
	$D2F7  90 06:       bcc +		; $D2FF
	$D2F9  A5 54:       lda $54
	$D2FB  49 05:       eor #$05
	$D2FD  85 54:       sta $54
+	$D2FF  A4 7C:       ldy $7C
	$D301  B9 45 DA:    lda _data_1A45_indexed,y
	$D304  18:          clc 
	$D305  65 54:       adc $54
	$D307  85 19:       sta $19
	$D309  A8:          tay 
	$D30A  B9 13 DA:    lda _DataPointerTableLo_1A13,y
	$D30D  85 22:       sta $22
	$D30F  B9 1D DA:    lda _DataPointerTableHi_1A13,y
	$D312  85 23:       sta $23
	$D314  B9 27 DA:    lda _DataPointerTableLo_1A27,y
	$D317  85 17:       sta $17
	$D319  B9 31 DA:    lda _DataPointerTableHi_1A27,y
	$D31C  85 18:       sta $18
	$D31E  B9 3B DA:    lda _data_1A3B_indexed,y
	$D321  85 1A:       sta $1A
	$D323  A2 08:       ldx #$08
	$D325  A5 5C:       lda $5C
	$D327  F0 52:       beq +++		; $D37B
	$D329  A5 7B:       lda $7B
	$D32B  49 01:       eor #$01
	$D32D  85 7B:       sta $7B
	$D32F  A9 D2:       lda #$D2
	$D331  20 08 D1:    jsr _func_1108
	$D334  A5 7B:       lda $7B
	$D336  F0 02:       beq +		; $D33A
	$D338  A9 40:       lda #$40
+	$D33A  A2 0A:       ldx #$0A
	$D33C  20 08 D1:    jsr _func_1108
	$D33F  A5 7B:       lda $7B
	$D341  D0 07:       bne +		; $D34A
	$D343  A9 66:       lda #$66
	$D345  A2 6E:       ldx #$6E
	$D347  4C 4E D3:    jmp ++		; $D34E

+	$D34A  A9 92:       lda #$92
	$D34C  A2 8A:       ldx #$8A
++	$D34E  8D 0B 02:    sta $020B
	$D351  8D 0B 03:    sta $030B
	$D354  8E 0F 02:    stx $020F
	$D357  8E 0F 03:    stx $030F
	$D35A  A5 5D:       lda $5D
	$D35C  A8:          tay 
	$D35D  0A:          asl a
	$D35E  18:          clc 
	$D35F  69 F3:       adc #$F3
	$D361  8D 09 02:    sta $0209
	$D364  8D 09 03:    sta $0309
	$D367  69 01:       adc #$01
	$D369  8D 0D 02:    sta $020D
	$D36C  8D 0D 03:    sta $030D
	$D36F  A5 7B:       lda $7B
	$D371  D0 06:       bne +		; $D379
	$D373  C8:          iny 
	$D374  98:          tya 
	$D375  29 03:       and #$03
	$D377  85 5D:       sta $5D
+	$D379  A2 10:       ldx #$10
+++	$D37B  A0 00:       ldy #$00
-	$D37D  B1 22:       lda ($22),y
	$D37F  18:          clc 
	$D380  69 B8:       adc #$B8
	$D382  9D 00 02:    sta $0200,x
	$D385  9D 00 03:    sta $0300,x
	$D388  E8:          inx 
	$D389  C8:          iny 
	$D38A  B1 22:       lda ($22),y
	$D38C  9D 00 02:    sta $0200,x
	$D38F  9D 00 03:    sta $0300,x
	$D392  E8:          inx 
	$D393  C8:          iny 
	$D394  B1 22:       lda ($22),y
	$D396  9D 00 02:    sta $0200,x
	$D399  9D 00 03:    sta $0300,x
	$D39C  E8:          inx 
	$D39D  C8:          iny 
	$D39E  B1 22:       lda ($22),y
	$D3A0  18:          clc 
	$D3A1  69 80:       adc #$80
	$D3A3  9D 00 02:    sta $0200,x
	$D3A6  9D 00 03:    sta $0300,x
	$D3A9  E8:          inx 
	$D3AA  C8:          iny 
	$D3AB  C4 17:       cpy $17
	$D3AD  90 CE:       bcc -		; $D37D
	$D3AF  86 2B:       stx $2B
-	$D3B1  B1 22:       lda ($22),y
	$D3B3  18:          clc 
	$D3B4  69 B8:       adc #$B8
	$D3B6  9D 00 02:    sta $0200,x
	$D3B9  E8:          inx 
	$D3BA  C8:          iny 
	$D3BB  B1 22:       lda ($22),y
	$D3BD  9D 00 02:    sta $0200,x
	$D3C0  E8:          inx 
	$D3C1  C8:          iny 
	$D3C2  B1 22:       lda ($22),y
	$D3C4  9D 00 02:    sta $0200,x
	$D3C7  E8:          inx 
	$D3C8  C8:          iny 
	$D3C9  B1 22:       lda ($22),y
	$D3CB  18:          clc 
	$D3CC  69 80:       adc #$80
	$D3CE  9D 00 02:    sta $0200,x
	$D3D1  E8:          inx 
	$D3D2  C8:          iny 
	$D3D3  C4 1A:       cpy $1A
	$D3D5  90 DA:       bcc -		; $D3B1
	$D3D7  A6 2B:       ldx $2B
-	$D3D9  B1 22:       lda ($22),y
	$D3DB  18:          clc 
	$D3DC  69 B8:       adc #$B8
	$D3DE  9D 00 03:    sta $0300,x
	$D3E1  E8:          inx 
	$D3E2  C8:          iny 
	$D3E3  B1 22:       lda ($22),y
	$D3E5  9D 00 03:    sta $0300,x
	$D3E8  E8:          inx 
	$D3E9  C8:          iny 
	$D3EA  B1 22:       lda ($22),y
	$D3EC  9D 00 03:    sta $0300,x
	$D3EF  E8:          inx 
	$D3F0  C8:          iny 
	$D3F1  B1 22:       lda ($22),y
	$D3F3  18:          clc 
	$D3F4  69 80:       adc #$80
	$D3F6  9D 00 03:    sta $0300,x
	$D3F9  E8:          inx 
	$D3FA  C8:          iny 
	$D3FB  C4 18:       cpy $18
	$D3FD  90 DA:       bcc -		; $D3D9
----	$D3FF  86 2B:       stx $2B
	$D401  A2 02:       ldx #$02
--	$D403  86 2C:       stx $2C
	$D405  B5 7D:       lda $7D,x
	$D407  B4 9B:       ldy $9B,x
	$D409  D0 02:       bne +		; $D40D
	$D40B  A9 03:       lda #$03
+	$D40D  85 1B:       sta $1B
	$D40F  B5 80:       lda $80,x
	$D411  85 1C:       sta $1C
	$D413  B5 89:       lda $89,x
	$D415  85 1D:       sta $1D
	$D417  B5 83:       lda $83,x
	$D419  B4 9B:       ldy $9B,x
	$D41B  D0 02:       bne +		; $D41F
	$D41D  A9 80:       lda #$80
+	$D41F  85 1E:       sta $1E
	$D421  84 1F:       sty $1F
	$D423  B5 86:       lda $86,x
	$D425  85 20:       sta $20
	$D427  A6 2B:       ldx $2B
	$D429  A4 1C:       ldy $1C
	$D42B  D0 03:       bne +		; $D430
	$D42D  4C C0 D4:    jmp ++		; $D4C0

+	$D430  B9 0B DD:    lda _data_1D0B_indexed,y
	$D433  18:          clc 
	$D434  65 1B:       adc $1B
	$D436  65 79:       adc $79
	$D438  A8:          tay 
	$D439  B9 14 DD:    lda _DataPointerTableLo_1D14,y
	$D43C  85 22:       sta $22
	$D43E  B9 84 DD:    lda _DataPointerTableHi_1D14,y
	$D441  85 23:       sta $23
	$D443  B9 1E DE:    lda _data_1E1E_indexed,y
	$D446  85 18:       sta $18
	$D448  B9 2C DE:    lda _data_1E2C_indexed,y
	$D44B  85 21:       sta $21
	$D44D  B9 F4 DD:    lda _data_1DF4_indexed,y
	$D450  C0 2A:       cpy #$2A
	$D452  90 0E:       bcc +		; $D462
	$D454  A9 14:       lda #$14
	$D456  C0 38:       cpy #$38
	$D458  90 08:       bcc +		; $D462
	$D45A  A9 08:       lda #$08
	$D45C  C0 54:       cpy #$54
	$D45E  90 02:       bcc +		; $D462
	$D460  A9 04:       lda #$04
+	$D462  85 17:       sta $17
	$D464  A0 00:       ldy #$00
-	$D466  B1 22:       lda ($22),y
	$D468  18:          clc 
	$D469  65 1D:       adc $1D
	$D46B  9D 00 02:    sta $0200,x
	$D46E  9D 00 03:    sta $0300,x
	$D471  C9 50:       cmp #$50
	$D473  B0 08:       bcs +		; $D47D
	$D475  A9 F0:       lda #$F0
	$D477  9D 00 02:    sta $0200,x
	$D47A  9D 00 03:    sta $0300,x
+	$D47D  E8:          inx 
	$D47E  C8:          iny 
	$D47F  B1 22:       lda ($22),y
	$D481  9D 00 02:    sta $0200,x
	$D484  9D 00 03:    sta $0300,x
	$D487  E8:          inx 
	$D488  C8:          iny 
	$D489  B1 22:       lda ($22),y
	$D48B  05 1F:       ora $1F
	$D48D  9D 00 02:    sta $0200,x
	$D490  9D 00 03:    sta $0300,x
	$D493  E8:          inx 
	$D494  C8:          iny 
	$D495  B1 22:       lda ($22),y
	$D497  18:          clc 
	$D498  65 1E:       adc $1E
	$D49A  9D 00 02:    sta $0200,x
	$D49D  9D 00 03:    sta $0300,x
	$D4A0  A9 00:       lda #$00
	$D4A2  85 1A:       sta $1A
	$D4A4  B1 22:       lda ($22),y
	$D4A6  10 02:       bpl +		; $D4AA
	$D4A8  E6 1A:       inc $1A
+	$D4AA  A5 1A:       lda $1A
	$D4AC  65 20:       adc $20
	$D4AE  29 01:       and #$01
	$D4B0  F0 08:       beq +		; $D4BA
	$D4B2  A9 F0:       lda #$F0
	$D4B4  9D FD 01:    sta $01FD,x
	$D4B7  9D FD 02:    sta $02FD,x
+	$D4BA  E8:          inx 
	$D4BB  C8:          iny 
	$D4BC  C4 17:       cpy $17
	$D4BE  90 A6:       bcc -		; $D466
++	$D4C0  A5 1C:       lda $1C
	$D4C2  C9 08:       cmp #$08
	$D4C4  D0 04:       bne +		; $D4CA -> $D5F7
	$D4C6  A5 17:       lda $17
	$D4C8  D0 03:       bne ++		; $D4CD
+	$D4CA  4C F7 D5:    jmp +++		; $D5F7

++	$D4CD  86 2B:       stx $2B
-	$D4CF  B1 22:       lda ($22),y
	$D4D1  18:          clc 
	$D4D2  65 1D:       adc $1D
	$D4D4  9D 00 02:    sta $0200,x
	$D4D7  C9 50:       cmp #$50
	$D4D9  B0 05:       bcs +		; $D4E0
	$D4DB  A9 F0:       lda #$F0
	$D4DD  9D 00 02:    sta $0200,x
+	$D4E0  E8:          inx 
	$D4E1  C8:          iny 
	$D4E2  B1 22:       lda ($22),y
	$D4E4  9D 00 02:    sta $0200,x
	$D4E7  E8:          inx 
	$D4E8  C8:          iny 
	$D4E9  B1 22:       lda ($22),y
	$D4EB  05 1F:       ora $1F
	$D4ED  9D 00 02:    sta $0200,x
	$D4F0  E8:          inx 
	$D4F1  C8:          iny 
	$D4F2  B1 22:       lda ($22),y
	$D4F4  18:          clc 
	$D4F5  65 1E:       adc $1E
	$D4F7  9D 00 02:    sta $0200,x
	$D4FA  A9 00:       lda #$00
	$D4FC  85 1A:       sta $1A
	$D4FE  B1 22:       lda ($22),y
	$D500  10 02:       bpl +		; $D504
	$D502  E6 1A:       inc $1A
+	$D504  A5 1A:       lda $1A
	$D506  65 20:       adc $20
	$D508  29 01:       and #$01
	$D50A  F0 05:       beq +		; $D511
	$D50C  A9 F0:       lda #$F0
	$D50E  9D FD 01:    sta $01FD,x
+	$D511  E8:          inx 
	$D512  C8:          iny 
	$D513  C4 21:       cpy $21
	$D515  90 B8:       bcc -		; $D4CF
	$D517  A6 2B:       ldx $2B
-	$D519  B1 22:       lda ($22),y
	$D51B  18:          clc 
	$D51C  65 1D:       adc $1D
	$D51E  9D 00 03:    sta $0300,x
	$D521  C9 50:       cmp #$50
	$D523  B0 05:       bcs +		; $D52A
	$D525  A9 F0:       lda #$F0
	$D527  9D 00 03:    sta $0300,x
+	$D52A  E8:          inx 
	$D52B  C8:          iny 
	$D52C  B1 22:       lda ($22),y
	$D52E  9D 00 03:    sta $0300,x
	$D531  E8:          inx 
	$D532  C8:          iny 
	$D533  B1 22:       lda ($22),y
	$D535  05 1F:       ora $1F
	$D537  9D 00 03:    sta $0300,x
	$D53A  E8:          inx 
	$D53B  C8:          iny 
	$D53C  B1 22:       lda ($22),y
	$D53E  18:          clc 
	$D53F  65 1E:       adc $1E
	$D541  9D 00 03:    sta $0300,x
	$D544  A9 00:       lda #$00
	$D546  85 1A:       sta $1A
	$D548  B1 22:       lda ($22),y
	$D54A  10 02:       bpl +		; $D54E
	$D54C  E6 1A:       inc $1A
+	$D54E  A5 1A:       lda $1A
	$D550  65 20:       adc $20
	$D552  29 01:       and #$01
	$D554  F0 05:       beq +		; $D55B
	$D556  A9 F0:       lda #$F0
	$D558  9D FD 02:    sta $02FD,x
+	$D55B  E8:          inx 
	$D55C  C8:          iny 
	$D55D  C4 18:       cpy $18
	$D55F  90 B8:       bcc -		; $D519
	$D561  A4 17:       ldy $17
	$D563  86 2B:       stx $2B
-	$D565  B1 22:       lda ($22),y
	$D567  18:          clc 
	$D568  65 1D:       adc $1D
	$D56A  9D 00 03:    sta $0300,x
	$D56D  C9 50:       cmp #$50
	$D56F  B0 05:       bcs +		; $D576
	$D571  A9 F0:       lda #$F0
	$D573  9D 00 03:    sta $0300,x
+	$D576  E8:          inx 
	$D577  C8:          iny 
	$D578  B1 22:       lda ($22),y
	$D57A  9D 00 03:    sta $0300,x
	$D57D  E8:          inx 
	$D57E  C8:          iny 
	$D57F  B1 22:       lda ($22),y
	$D581  05 1F:       ora $1F
	$D583  9D 00 03:    sta $0300,x
	$D586  E8:          inx 
	$D587  C8:          iny 
	$D588  B1 22:       lda ($22),y
	$D58A  18:          clc 
	$D58B  65 1E:       adc $1E
	$D58D  9D 00 03:    sta $0300,x
	$D590  A9 00:       lda #$00
	$D592  85 1A:       sta $1A
	$D594  B1 22:       lda ($22),y
	$D596  10 02:       bpl +		; $D59A
	$D598  E6 1A:       inc $1A
+	$D59A  A5 1A:       lda $1A
	$D59C  65 20:       adc $20
	$D59E  29 01:       and #$01
	$D5A0  F0 05:       beq +		; $D5A7
	$D5A2  A9 F0:       lda #$F0
	$D5A4  9D FD 02:    sta $02FD,x
+	$D5A7  E8:          inx 
	$D5A8  C8:          iny 
	$D5A9  C4 21:       cpy $21
	$D5AB  90 B8:       bcc -		; $D565
	$D5AD  A6 2B:       ldx $2B
-	$D5AF  B1 22:       lda ($22),y
	$D5B1  18:          clc 
	$D5B2  65 1D:       adc $1D
	$D5B4  9D 00 02:    sta $0200,x
	$D5B7  C9 50:       cmp #$50
	$D5B9  B0 05:       bcs +		; $D5C0
	$D5BB  A9 F0:       lda #$F0
	$D5BD  9D 00 02:    sta $0200,x
+	$D5C0  E8:          inx 
	$D5C1  C8:          iny 
	$D5C2  B1 22:       lda ($22),y
	$D5C4  9D 00 02:    sta $0200,x
	$D5C7  E8:          inx 
	$D5C8  C8:          iny 
	$D5C9  B1 22:       lda ($22),y
	$D5CB  05 1F:       ora $1F
	$D5CD  9D 00 02:    sta $0200,x
	$D5D0  E8:          inx 
	$D5D1  C8:          iny 
	$D5D2  B1 22:       lda ($22),y
	$D5D4  18:          clc 
	$D5D5  65 1E:       adc $1E
	$D5D7  9D 00 02:    sta $0200,x
	$D5DA  A9 00:       lda #$00
	$D5DC  85 1A:       sta $1A
	$D5DE  B1 22:       lda ($22),y
	$D5E0  10 02:       bpl +		; $D5E4
	$D5E2  E6 1A:       inc $1A
+	$D5E4  A5 1A:       lda $1A
	$D5E6  65 20:       adc $20
	$D5E8  29 01:       and #$01
	$D5EA  F0 05:       beq +		; $D5F1
	$D5EC  A9 F0:       lda #$F0
	$D5EE  9D FD 01:    sta $01FD,x
+	$D5F1  E8:          inx 
	$D5F2  C8:          iny 
	$D5F3  C4 18:       cpy $18
	$D5F5  90 B8:       bcc -		; $D5AF
+++	$D5F7  86 2B:       stx $2B
	$D5F9  A6 2C:       ldx $2C
	$D5FB  CA:          dex 
	$D5FC  30 03:       bmi +		; $D601
	$D5FE  4C 03 D4:    jmp --		; $D403

+	$D601  A6 2B:       ldx $2B
	$D603  A5 56:       lda $56
	$D605  05 5A:       ora $5A
	$D607  D0 6A:       bne +		; $D673
	$D609  A4 19:       ldy $19
	$D60B  B9 13 DA:    lda _DataPointerTableLo_1A13,y
	$D60E  85 22:       sta $22
	$D610  B9 1D DA:    lda _DataPointerTableHi_1A13,y
	$D613  85 23:       sta $23
	$D615  B9 31 DA:    lda _DataPointerTableHi_1A27,y
	$D618  85 17:       sta $17
	$D61A  B9 3B DA:    lda _data_1A3B_indexed,y
	$D61D  85 1A:       sta $1A
	$D61F  B9 27 DA:    lda _DataPointerTableLo_1A27,y
	$D622  A8:          tay 
	$D623  86 2B:       stx $2B
-	$D625  B1 22:       lda ($22),y
	$D627  18:          clc 
	$D628  69 B8:       adc #$B8
	$D62A  9D 00 03:    sta $0300,x
	$D62D  E8:          inx 
	$D62E  C8:          iny 
	$D62F  B1 22:       lda ($22),y
	$D631  9D 00 03:    sta $0300,x
	$D634  E8:          inx 
	$D635  C8:          iny 
	$D636  B1 22:       lda ($22),y
	$D638  9D 00 03:    sta $0300,x
	$D63B  E8:          inx 
	$D63C  C8:          iny 
	$D63D  B1 22:       lda ($22),y
	$D63F  18:          clc 
	$D640  69 80:       adc #$80
	$D642  9D 00 03:    sta $0300,x
	$D645  E8:          inx 
	$D646  C8:          iny 
	$D647  C4 1A:       cpy $1A
	$D649  90 DA:       bcc -		; $D625
	$D64B  A6 2B:       ldx $2B
-	$D64D  B1 22:       lda ($22),y
	$D64F  18:          clc 
	$D650  69 B8:       adc #$B8
	$D652  9D 00 02:    sta $0200,x
	$D655  E8:          inx 
	$D656  C8:          iny 
	$D657  B1 22:       lda ($22),y
	$D659  9D 00 02:    sta $0200,x
	$D65C  E8:          inx 
	$D65D  C8:          iny 
	$D65E  B1 22:       lda ($22),y
	$D660  9D 00 02:    sta $0200,x
	$D663  E8:          inx 
	$D664  C8:          iny 
	$D665  B1 22:       lda ($22),y
	$D667  18:          clc 
	$D668  69 80:       adc #$80
	$D66A  9D 00 02:    sta $0200,x
	$D66D  E8:          inx 
	$D66E  C8:          iny 
	$D66F  C4 17:       cpy $17
	$D671  90 DA:       bcc -		; $D64D
+	$D673  86 2B:       stx $2B
	$D675  A5 46:       lda $46
	$D677  18:          clc 
	$D678  65 60:       adc $60
	$D67A  85 46:       sta $46
	$D67C  A0 01:       ldy #$01
	$D67E  B1 66:       lda ($66),y
	$D680  85 17:       sta $17
	$D682  C5 46:       cmp $46
	$D684  B0 20:       bcs ++		; $D6A6
	$D686  A5 46:       lda $46
	$D688  38:          sec 
	$D689  E5 17:       sbc $17
	$D68B  85 46:       sta $46
	$D68D  A5 66:       lda $66
	$D68F  18:          clc 
	$D690  69 02:       adc #$02
	$D692  85 66:       sta $66
	$D694  90 02:       bcc +		; $D698
	$D696  E6 67:       inc $67
+ -	$D698  B1 66:       lda ($66),y
	$D69A  D0 0A:       bne ++		; $D6A6
	$D69C  A9 00:       lda #$00
	$D69E  85 66:       sta $66
	$D6A0  A9 07:       lda #$07
	$D6A2  85 67:       sta $67
	$D6A4  D0 F2:       bne -		; $D698

++	$D6A6  A5 66:       lda $66
	$D6A8  85 68:       sta $68
	$D6AA  A5 67:       lda $67
	$D6AC  85 69:       sta $69
	$D6AE  A5 46:       lda $46
	$D6B0  85 6A:       sta $6A
	$D6B2  A6 2B:       ldx $2B
	$D6B4  A5 56:       lda $56
	$D6B6  05 5A:       ora $5A
	$D6B8  D0 08:       bne +		; $D6C2
-                           ; Delay loop begin: 12 cycles (4.0 cycles per byte); ends at $16BD
	$D6BA  20 0B FF:    jsr _func_3F0B		; $FF0B -> rts
                            ; End of delay loop (3 bytes)
	$D6BD  E8:          inx 
	$D6BE  E0 A0:       cpx #$A0
	$D6C0  90 F8:       bcc -		; $D6BA
+	$D6C2  A6 2B:       ldx $2B
	$D6C4  E0 B0:       cpx #$B0
	$D6C6  B0 0D:       bcs +		; $D6D5
-	$D6C8  A9 FF:       lda #$FF
	$D6CA  9D 00 02:    sta $0200,x
	$D6CD  9D 00 03:    sta $0300,x
	$D6D0  E8:          inx 
	$D6D1  E0 B0:       cpx #$B0
	$D6D3  90 F3:       bcc -		; $D6C8
+	$D6D5  86 2B:       stx $2B
	$D6D7  20 08 C2:    jsr _func_0208
	$D6DA  A2 36:       ldx #$36
--	$D6DC  E6 6A:       inc $6A
	$D6DE  A0 01:       ldy #$01
	$D6E0  B1 68:       lda ($68),y
	$D6E2  85 17:       sta $17
	$D6E4  C5 6A:       cmp $6A
	$D6E6  B0 29:       bcs ++		; $D711
	$D6E8  20 22 D7:    jsr _func_1722
	$D6EB  A5 2B:       lda $2B
	$D6ED  10 32:       bpl +++		; $D721 -> rts
	$D6EF  A5 6A:       lda $6A
	$D6F1  38:          sec 
	$D6F2  E5 17:       sbc $17
	$D6F4  85 6A:       sta $6A
	$D6F6  A5 68:       lda $68
	$D6F8  18:          clc 
	$D6F9  69 02:       adc #$02
	$D6FB  85 68:       sta $68
	$D6FD  90 02:       bcc +		; $D701
	$D6FF  E6 69:       inc $69
+ -	$D701  A0 01:       ldy #$01
	$D703  B1 68:       lda ($68),y
	$D705  D0 0A:       bne ++		; $D711
	$D707  A9 00:       lda #$00
	$D709  85 68:       sta $68
	$D70B  A9 07:       lda #$07
	$D70D  85 69:       sta $69
	$D70F  D0 F0:       bne -		; $D701

++	$D711  CA:          dex 
	$D712  D0 C8:       bne --		; $D6DC
	$D714  A6 2B:       ldx $2B
	$D716  A9 F0:       lda #$F0
-	$D718  9D 00 02:    sta $0200,x
	$D71B  9D 00 03:    sta $0300,x
	$D71E  E8:          inx 
	$D71F  D0 F7:       bne -		; $D718
+++	$D721  60:          rts 
;------------------------------------------
_func_1722
	$D722  A0 00:       ldy #$00
	$D724  B1 68:       lda ($68),y
	$D726  D0 01:       bne +		; $D729
	$D728  60:          rts 

+	$D729  85 19:       sta $19
	$D72B  86 18:       stx $18
	$D72D  8A:          txa 
	$D72E  0A:          asl a
	$D72F  0A:          asl a
	$D730  A8:          tay 
	$D731  B9 49 E4:    lda _data_2449_indexed,y
	$D734  18:          clc 
	$D735  69 1C:       adc #$1C
	$D737  85 1A:       sta $1A
	$D739  38:          sec 
	$D73A  E9 6B:       sbc #$6B
	$D73C  85 1B:       sta $1B
	$D73E  A8:          tay 
	$D73F  4A:          lsr a
	$D740  4A:          lsr a
	$D741  4A:          lsr a
	$D742  85 20:       sta $20
	$D744  B9 69 E5:    lda _data_2569_indexed,y
	$D747  85 9F:       sta $9F
	$D749  A9 B0:       lda #$B0
	$D74B  85 A1:       sta $A1
	$D74D  20 97 E9:    jsr _func_2997
	$D750  A5 56:       lda $56
	$D752  05 5A:       ora $5A
	$D754  D0 33:       bne +++		; $D789
	$D756  A5 1A:       lda $1A
	$D758  C9 C0:       cmp #$C0
	$D75A  90 2D:       bcc +++		; $D789
	$D75C  C9 DB:       cmp #$DB
	$D75E  B0 29:       bcs +++		; $D789
	$D760  A5 4D:       lda $4D
	$D762  D0 0C:       bne +		; $D770
	$D764  A5 19:       lda $19
	$D766  30 21:       bmi +++		; $D789
	$D768  A5 4C:       lda $4C
	$D76A  C9 80:       cmp #$80
	$D76C  90 1B:       bcc +++		; $D789
	$D76E  B0 0A:       bcs ++		; $D77A
+	$D770  A5 19:       lda $19
	$D772  10 15:       bpl +++		; $D789
	$D774  A5 4C:       lda $4C
	$D776  C9 80:       cmp #$80
	$D778  B0 0F:       bcs +++		; $D789
++	$D77A  A5 19:       lda $19
	$D77C  C5 57:       cmp $57
	$D77E  F0 09:       beq +++		; $D789
	$D780  85 57:       sta $57
	$D782  20 0D E4:    jsr _func_240D
	$D785  A9 03:       lda #$03
	$D787  85 58:       sta $58
+++	$D789  A5 5F:       lda $5F
	$D78B  F0 0A:       beq +		; $D797
	$D78D  A5 58:       lda $58
	$D78F  F0 06:       beq +		; $D797
	$D791  C6 58:       dec $58
	$D793  D0 02:       bne +		; $D797
	$D795  E6 57:       inc $57
+	$D797  A4 1B:       ldy $1B
	$D799  A9 7C:       lda #$7C
	$D79B  38:          sec 
	$D79C  F1 3A:       sbc ($3A),y
	$D79E  0A:          asl a
	$D79F  85 1C:       sta $1C
	$D7A1  A9 00:       lda #$00
	$D7A3  69 00:       adc #$00
	$D7A5  85 1D:       sta $1D
	$D7A7  A5 19:       lda $19
	$D7A9  30 12:       bmi +		; $D7BD
	$D7AB  A5 1C:       lda $1C
	$D7AD  18:          clc 
	$D7AE  65 A3:       adc $A3
	$D7B0  85 1C:       sta $1C
	$D7B2  90 16:       bcc ++		; $D7CA
	$D7B4  A5 1D:       lda $1D
	$D7B6  49 01:       eor #$01
	$D7B8  85 1D:       sta $1D
	$D7BA  4C CA D7:    jmp ++		; $D7CA

+	$D7BD  A5 1C:       lda $1C
	$D7BF  38:          sec 
	$D7C0  E5 A3:       sbc $A3
	$D7C2  85 1C:       sta $1C
	$D7C4  A5 1D:       lda $1D
	$D7C6  E9 00:       sbc #$00
	$D7C8  85 1D:       sta $1D
++	$D7CA  A5 1D:       lda $1D
	$D7CC  F0 03:       beq +		; $D7D1
-	$D7CE  4C CF D8:    jmp ++++		; $D8CF

+	$D7D1  A5 1C:       lda $1C
	$D7D3  C9 F8:       cmp #$F8
	$D7D5  B0 F7:       bcs -		; $D7CE -> $D8CF
	$D7D7  A5 19:       lda $19
	$D7D9  29 0F:       and #$0F
	$D7DB  C9 02:       cmp #$02
	$D7DD  B0 45:       bcs _loc_1824
	$D7DF  A4 20:       ldy $20
	$D7E1  BE E8 D8:    ldx _data_18E8_indexed,y
	$D7E4  BD D2 D8:    lda _data_18D2_indexed,x
	$D7E7  85 1E:       sta $1E
	$D7E9  BC D7 D8:    ldy _data_18D7_indexed,x
	$D7EC  A6 2B:       ldx $2B
_loc_17EE
	$D7EE  A5 1A:       lda $1A
	$D7F0  9D 00 02:    sta $0200,x
	$D7F3  9D 00 03:    sta $0300,x
	$D7F6  A5 1A:       lda $1A
	$D7F8  38:          sec 
	$D7F9  E9 08:       sbc #$08
	$D7FB  85 1A:       sta $1A
	$D7FD  E8:          inx 
	$D7FE  B9 DC D8:    lda _data_18DC_indexed,y
DataTableEntry_1801
	$D801  9D 00 02:    sta $0200,x
	$D804  9D 00 03:    sta $0300,x
	$D807  C8:          iny 
	$D808  E8:          inx 
	$D809  A9 00:       lda #$00
	$D80B  9D 00 02:    sta $0200,x
	$D80E  9D 00 03:    sta $0300,x
	$D811  E8:          inx 
	$D812  A5 1C:       lda $1C
	$D814  9D 00 02:    sta $0200,x
	$D817  9D 00 03:    sta $0300,x
	$D81A  E8:          inx 
	$D81B  10 04:       bpl +		; $D821 -> $D8CD
	$D81D  C6 1E:       dec $1E
	$D81F  D0 CD:       bne _loc_17EE
+	$D821  4C CD D8:    jmp +++		; $D8CD
;------------------------------------------
_loc_1824
	$D824  C9 02:       cmp #$02
	$D826  D0 4D:       bne +		; $D875
	$D828  A4 20:       ldy $20
	$D82A  BE E8 D8:    ldx _data_18E8_indexed,y
	$D82D  BD F8 D8:    lda _data_18F8_indexed,x
	$D830  85 1E:       sta $1E
	$D832  A4 59:       ldy $59
	$D834  B9 CA D9:    lda _data_19CA_indexed,y
	$D837  18:          clc 
	$D838  7D FD D8:    adc _data_18FD_indexed,x
	$D83B  A8:          tay 
	$D83C  A6 2B:       ldx $2B
-	$D83E  B9 02 D9:    lda _data_1902_indexed,y
	$D841  18:          clc 
	$D842  65 1A:       adc $1A
	$D844  9D 00 02:    sta $0200,x
	$D847  9D 00 03:    sta $0300,x
	$D84A  E8:          inx 
	$D84B  B9 34 D9:    lda _data_1934_indexed,y
	$D84E  9D 00 02:    sta $0200,x
	$D851  9D 00 03:    sta $0300,x
	$D854  E8:          inx 
	$D855  B9 66 D9:    lda _data_1966_indexed,y
	$D858  9D 00 02:    sta $0200,x
	$D85B  9D 00 03:    sta $0300,x
	$D85E  E8:          inx 
	$D85F  B9 98 D9:    lda _data_1998_indexed,y
	$D862  18:          clc 
	$D863  65 1C:       adc $1C
	$D865  9D 00 02:    sta $0200,x
	$D868  9D 00 03:    sta $0300,x
	$D86B  C8:          iny 
	$D86C  E8:          inx 
	$D86D  10 5E:       bpl +++		; $D8CD
	$D86F  C6 1E:       dec $1E
	$D871  D0 CB:       bne -		; $D83E
	$D873  F0 58:       beq +++		; $D8CD
+	$D875  A4 20:       ldy $20
	$D877  BE E8 D8:    ldx _data_18E8_indexed,y
	$D87A  BD CD D9:    lda _data_19CD_indexed,x
	$D87D  85 1E:       sta $1E
	$D87F  A9 01:       lda #$01
	$D881  A4 19:       ldy $19
	$D883  30 02:       bmi +		; $D887
	$D885  A9 41:       lda #$41
+	$D887  85 21:       sta $21
	$D889  BD D2 D9:    lda _data_19D2_indexed,x
	$D88C  A8:          tay 
	$D88D  A6 2B:       ldx $2B
-	$D88F  B9 D7 D9:    lda _data_19D7_indexed,y
	$D892  18:          clc 
	$D893  65 1A:       adc $1A
	$D895  9D 00 02:    sta $0200,x
	$D898  9D 00 03:    sta $0300,x
	$D89B  E8:          inx 
	$D89C  B9 E6 D9:    lda _data_19E6_indexed,y
	$D89F  9D 00 02:    sta $0200,x
	$D8A2  9D 00 03:    sta $0300,x
	$D8A5  E8:          inx 
	$D8A6  A5 21:       lda $21
	$D8A8  9D 00 02:    sta $0200,x
	$D8AB  9D 00 03:    sta $0300,x
	$D8AE  E8:          inx 
	$D8AF  A5 19:       lda $19
	$D8B1  30 06:       bmi +		; $D8B9
	$D8B3  B9 04 DA:    lda _data_1A04_indexed,y
	$D8B6  4C BC D8:    jmp ++		; $D8BC

+	$D8B9  B9 F5 D9:    lda _data_19F5_indexed,y
++	$D8BC  18:          clc 
	$D8BD  65 1C:       adc $1C
	$D8BF  9D 00 02:    sta $0200,x
	$D8C2  9D 00 03:    sta $0300,x
	$D8C5  C8:          iny 
	$D8C6  E8:          inx 
	$D8C7  10 04:       bpl +++		; $D8CD
	$D8C9  C6 1E:       dec $1E
	$D8CB  D0 C2:       bne -		; $D88F
+++	$D8CD  86 2B:       stx $2B
++++	$D8CF  A6 18:       ldx $18
	$D8D1  60:          rts 
;------------------------------------------
_data_18D2_indexed
	$D8D2               .byte $01,$01,$02,$03,$05
_data_18D7_indexed
	$D8D7               .byte $00,$01,$02,$04,$07
_data_18DC_indexed
	$D8DC               .byte $D1,$D2,$D4,$D3,$D7,$D6,$D5,$DB,$D9,$DA,$D9,$D8
_data_18E8_indexed
	$D8E8               .byte $00,$00,$01,$02,$02,$03,$03,$03,$04,$04,$04,$04,$04,$04,$04,$04
_data_18F8_indexed
	$D8F8               .byte $01,$01,$02,$06,$0A
_data_18FD_indexed
	$D8FD               .byte $00,$01,$02,$04,$0A
_data_1902_indexed
	$D902               .byte $E0,$E0,$E8,$E8,$F0,$F0,$F8,$F8,$00,$00,$00,$00,$F8,$00,$F0,$F0
	$D912               .byte $F8,$F8,$00,$00,$E0,$E0,$E8,$E8,$F0,$F0,$F8,$F8,$00,$00,$00,$00
	$D922               .byte $F8,$00,$F0,$F0,$F8,$F8,$00,$00,$E0,$E0,$E8,$E8,$F0,$F0,$F8,$F8
	$D932               .byte $00,$00
_data_1934_indexed
	$D934               .byte $EF,$39,$F0,$F0,$E6,$E6,$F1,$F2,$F0,$F0,$DC,$DD,$EA,$EB,$E0,$EC
	$D944               .byte $E0,$ED,$E0,$EE,$E9,$E9,$E4,$E5,$E4,$E4,$E9,$E9,$E9,$E9,$DC,$DD
	$D954               .byte $DE,$DF,$E0,$E1,$E0,$E2,$E0,$E3,$E4,$E5,$E4,$E4,$E6,$E6,$E7,$E8
	$D964               .byte $E9,$E9
_data_1966_indexed
	$D966               .byte $00,$00,$00,$40,$00,$40,$00,$00,$00,$40,$00,$00,$00,$00,$00,$00
	$D976               .byte $00,$00,$00,$00,$00,$40,$00,$00,$00,$40,$00,$40,$00,$40,$00,$00
	$D986               .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$00,$40,$00,$00
	$D996               .byte $00,$40
_data_1998_indexed
	$D998               .byte $FC,$04,$FC,$04,$FC,$04,$FC,$04,$FC,$04,$04,$04,$04,$04,$FC,$04
	$D9A8               .byte $FC,$04,$FC,$04,$FC,$04,$FC,$04,$FC,$04,$FC,$04,$FC,$04,$04,$04
	$D9B8               .byte $04,$04,$FC,$04,$FC,$04,$FC,$04,$FC,$04,$FC,$04,$FC,$04,$FC,$04
	$D9C8               .byte $FC,$04
_data_19CA_indexed
	$D9CA               .byte $F6,$0A,$1E
_data_19CD_indexed
	$D9CD               .byte $01,$01,$02,$04,$07
_data_19D2_indexed
	$D9D2               .byte $00,$01,$02,$04,$08
_data_19D7_indexed
	$D9D7               .byte $00,$00,$F8,$00,$F0,$F0,$F8,$00,$E0,$E0,$E8,$E8,$F0,$F8,$00
_data_19E6_indexed
	$D9E6               .byte $01,$0B,$0C,$0D,$47,$55,$85,$85,$8D,$91,$2F,$34,$32,$32,$32
_data_19F5_indexed
	$D9F5               .byte $04,$04,$04,$04,$03,$0B,$03,$03,$00,$08,$00,$08,$04,$04,$04
_data_1A04_indexed
	$DA04               .byte $04,$04,$04,$04,$04,$FC,$03,$03,$08,$00,$08,$00,$04,$04,$04
_DataPointerTableLo_1A13
	$DA13  5C:          .byte < (DataTableEntry_1A5C)
	$DA14  A4:          .byte < (DataTableEntry_1AA4)
	$DA15  E8:          .byte < (DataTableEntry_1AE8)
	$DA16  28:          .byte < (DataTableEntry_1B28)
	$DA17  6C:          .byte < (DataTableEntry_1B6C)
	$DA18  B4:          .byte < (DataTableEntry_1BB4)
	$DA19  FC:          .byte < (DataTableEntry_1BFC)
	$DA1A  40:          .byte < (DataTableEntry_1C40)
	$DA1B  80:          .byte < (DataTableEntry_1C80)
	$DA1C  C4:          .byte < (DataTableEntry_1CC4)
_DataPointerTableHi_1A13
	$DA1D  DA:          .byte > (DataTableEntry_1A5C)
	$DA1E  DA:          .byte > (DataTableEntry_1AA4)
	$DA1F  DA:          .byte > (DataTableEntry_1AE8)
	$DA20  DB:          .byte > (DataTableEntry_1B28)
	$DA21  DB:          .byte > (DataTableEntry_1B6C)
	$DA22  DB:          .byte > (DataTableEntry_1BB4)
	$DA23  DB:          .byte > (DataTableEntry_1BFC)
	$DA24  DC:          .byte > (DataTableEntry_1C40)
	$DA25  DC:          .byte > (DataTableEntry_1C80)
	$DA26  DC:          .byte > (DataTableEntry_1CC4)
_DataPointerTableLo_1A27
	$DA27  30:          .byte < ($4830)
	$DA28  2C:          .byte < ($442C)
	$DA29  30:          .byte < ($4030)
	$DA2A  2C:          .byte < ($442C)
	$DA2B  30:          .byte < ($4830)
	$DA2C               .byte $30,$2C,$30,$2C,$30
_DataPointerTableHi_1A27
	$DA31  48:          .byte > ($4830)
	$DA32  44:          .byte > ($442C)
	$DA33  40:          .byte > ($4030)
	$DA34  44:          .byte > ($442C)
	$DA35  48:          .byte > ($4830)
	$DA36               .byte $48,$44,$40,$44,$48
_data_1A3B_indexed
	$DA3B               .byte $3C,$38,$38,$38,$3C,$3C,$38,$38,$38,$3C
_data_1A45_indexed
	$DA45               .byte $00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$03,$03,$03,$03
	$DA55               .byte $03,$03,$03,$03,$03,$03,$04
DataTableEntry_1A5C
	$DA5C               .byte $00,$1F,$40,$E8,$00,$1D,$40,$F8,$00,$1C,$40,$00,$08,$23,$40,$F0
	$DA6C               .byte $08,$22,$40,$F8,$08,$21,$40,$00,$10,$28,$40,$F8,$10,$27,$40,$00
	$DA7C               .byte $10,$26,$40,$08,$18,$2D,$40,$F8,$18,$2C,$40,$00,$18,$2B,$40,$08
	$DA8C               .byte $08,$20,$40,$08,$10,$25,$40,$10,$18,$2A,$40,$10,$08,$24,$40,$E8
	$DA9C               .byte $10,$29,$40,$F0,$18,$2E,$40,$F0
DataTableEntry_1AA4
	$DAA4               .byte $00,$00,$40,$EE,$00,$0A,$40,$06,$08,$11,$40,$F6,$08,$10,$40,$FE
	$DAB4               .byte $08,$0F,$40,$06,$10,$16,$40,$F6,$10,$15,$40,$FE,$10,$14,$40,$06
	$DAC4               .byte $18,$1A,$40,$F6,$18,$19,$40,$FE,$18,$18,$40,$06,$08,$0E,$40,$0E
	$DAD4               .byte $10,$13,$40,$0E,$18,$07,$40,$0E,$08,$12,$40,$EE,$10,$17,$40,$EE
	$DAE4               .byte $18,$1B,$40,$EE
DataTableEntry_1AE8
	$DAE8               .byte $00,$00,$00,$F0,$00,$00,$40,$08,$08,$02,$00,$F0,$08,$03,$00,$F8
	$DAF8               .byte $08,$03,$40,$00,$08,$02,$40,$08,$10,$05,$00,$F4,$10,$06,$00,$FC
	$DB08               .byte $10,$05,$40,$04,$18,$08,$00,$F4,$18,$09,$00,$FC,$18,$08,$40,$04
	$DB18               .byte $10,$04,$00,$EC,$18,$07,$00,$EC,$10,$04,$40,$0C,$18,$07,$40,$0C
DataTableEntry_1B28
	$DB28               .byte $00,$0A,$00,$F2,$00,$00,$00,$0A,$08,$0F,$00,$F2,$08,$10,$00,$FA
	$DB38               .byte $08,$11,$00,$02,$10,$14,$00,$F2,$10,$15,$00,$FA,$10,$16,$00,$02
	$DB48               .byte $18,$18,$00,$F2,$18,$19,$00,$FA,$18,$1A,$00,$02,$08,$0E,$00,$EA
	$DB58               .byte $10,$13,$00,$EA,$18,$07,$00,$EA,$08,$12,$00,$0A,$10,$17,$00,$0A
	$DB68               .byte $18,$1B,$00,$0A
DataTableEntry_1B6C
	$DB6C               .byte $00,$1C,$00,$F8,$00,$1D,$00,$00,$00,$1F,$00,$10,$08,$21,$00,$F8
	$DB7C               .byte $08,$22,$00,$00,$08,$23,$00,$08,$10,$26,$00,$F0,$10,$27,$00,$F8
	$DB8C               .byte $10,$28,$00,$00,$18,$2B,$00,$F0,$18,$2C,$00,$F8,$18,$2D,$00,$00
	$DB9C               .byte $08,$20,$00,$F0,$10,$25,$00,$E8,$18,$2A,$00,$E8,$08,$24,$00,$10
	$DBAC               .byte $10,$29,$00,$08,$18,$2E,$00,$08
DataTableEntry_1BB4
	$DBB4               .byte $00,$3B,$40,$E8,$00,$1D,$40,$F8,$00,$1E,$40,$00,$08,$23,$40,$F0
	$DBC4               .byte $08,$22,$40,$F8,$08,$3A,$40,$00,$10,$3E,$40,$F8,$10,$27,$40,$00
	$DBD4               .byte $10,$26,$40,$08,$18,$2D,$40,$F8,$18,$2C,$40,$00,$18,$2B,$40,$08
	$DBE4               .byte $08,$20,$40,$08,$10,$3D,$40,$10,$18,$2A,$40,$10,$08,$3C,$40,$E8
	$DBF4               .byte $10,$3F,$40,$F0,$18,$2E,$40,$F0
DataTableEntry_1BFC
	$DBFC               .byte $00,$00,$40,$EE,$00,$0A,$40,$06,$08,$11,$40,$F6,$08,$10,$40,$FE
	$DC0C               .byte $08,$33,$40,$06,$10,$37,$40,$F6,$10,$15,$40,$FE,$10,$14,$40,$06
	$DC1C               .byte $18,$1A,$40,$F6,$18,$19,$40,$FE,$18,$18,$40,$06,$08,$0E,$40,$0E
	$DC2C               .byte $10,$36,$40,$0E,$18,$07,$40,$0E,$08,$35,$40,$EE,$10,$38,$40,$EE
	$DC3C               .byte $18,$1B,$40,$EE
DataTableEntry_1C40
	$DC40               .byte $00,$00,$00,$F0,$00,$00,$40,$08,$08,$30,$00,$F0,$08,$03,$00,$F8
	$DC50               .byte $08,$03,$40,$00,$08,$30,$40,$08,$10,$05,$00,$F4,$10,$06,$00,$FC
	$DC60               .byte $10,$05,$40,$04,$18,$08,$00,$F4,$18,$09,$00,$FC,$18,$08,$40,$04
	$DC70               .byte $10,$31,$00,$EC,$18,$07,$00,$EC,$10,$31,$40,$0C,$18,$07,$40,$0C
DataTableEntry_1C80
	$DC80               .byte $00,$0A,$00,$F2,$00,$00,$00,$0A,$08,$33,$00,$F2,$08,$10,$00,$FA
	$DC90               .byte $08,$11,$00,$02,$10,$14,$00,$F2,$10,$15,$00,$FA,$10,$37,$00,$02
	$DCA0               .byte $18,$18,$00,$F2,$18,$19,$00,$FA,$18,$1A,$00,$02,$08,$0E,$00,$EA
	$DCB0               .byte $10,$36,$00,$EA,$18,$07,$00,$EA,$08,$35,$00,$0A,$10,$38,$00,$0A
	$DCC0               .byte $18,$1B,$00,$0A
DataTableEntry_1CC4
	$DCC4               .byte $00,$1E,$00,$F8,$00,$1D,$00,$00,$00,$3B,$00,$10,$08,$3A,$00,$F8
	$DCD4               .byte $08,$22,$00,$00,$08,$23,$00,$08,$10,$26,$00,$F0,$10,$27,$00,$F8
	$DCE4               .byte $10,$3E,$00,$00,$18,$2B,$00,$F0,$18,$2C,$00,$F8,$18,$2D,$00,$00
	$DCF4               .byte $08,$20,$00,$F0,$10,$3D,$00,$E8,$18,$2A,$00,$E8,$08,$3C,$00,$10
	$DD04               .byte $10,$3F,$00,$08,$18,$2E,$00
_data_1D0B_indexed
	$DD0B               .byte $08,$62,$54,$46,$38,$2A,$1C,$0E,$00
_DataPointerTableLo_1D14
	$DD14  00:          .byte < ($00)
	$DD15  5C:          .byte < (DataTableEntry_1A5C)
	$DD16  A4:          .byte < (DataTableEntry_1AA4)
	$DD17  E8:          .byte < (DataTableEntry_1AE8)
	$DD18  28:          .byte < (DataTableEntry_1B28)
	$DD19  6C:          .byte < (DataTableEntry_1B6C)
	$DD1A  00:          .byte < ($00)
	$DD1B  00:          .byte < ($00)
	$DD1C  B4:          .byte < (DataTableEntry_1BB4)
	$DD1D  FC:          .byte < (DataTableEntry_1BFC)
	$DD1E  40:          .byte < (DataTableEntry_1C40)
	$DD1F  80:          .byte < (DataTableEntry_1C80)
	$DD20  C4:          .byte < (DataTableEntry_1CC4)
	$DD21  00:          .byte < ($00)
	$DD22  00:          .byte < ($00)
	$DD23  3A:          .byte < (DataTableEntry_1E3A)
	$DD24  6A:          .byte < (DataTableEntry_1E6A)
	$DD25  96:          .byte < (DataTableEntry_1E96)
	$DD26  C2:          .byte < (DataTableEntry_1EC2)
	$DD27  EE:          .byte < (DataTableEntry_1EEE)
	$DD28  00:          .byte < ($00)
	$DD29  00:          .byte < ($00)
	$DD2A  1E:          .byte < (DataTableEntry_1F1E)
	$DD2B  4E:          .byte < (DataTableEntry_1F4E)
	$DD2C  7A:          .byte < (DataTableEntry_1F7A)
	$DD2D  A6:          .byte < (DataTableEntry_1FA6)
	$DD2E  D2:          .byte < (DataTableEntry_1FD2)
	$DD2F  00:          .byte < ($00)
	$DD30  02:          .byte < (DataTableEntry_2002)
	$DD31  22:          .byte < (DataTableEntry_2022)
	$DD32  3A:          .byte < (DataTableEntry_203A)
	$DD33  52:          .byte < (DataTableEntry_2052)
	$DD34  6A:          .byte < (DataTableEntry_206A)
	$DD35  82:          .byte < (DataTableEntry_2082)
	$DD36  9A:          .byte < (DataTableEntry_209A)
	$DD37  02:          .byte < (DataTableEntry_2002)
	$DD38  22:          .byte < (DataTableEntry_2022)
	$DD39  3A:          .byte < (DataTableEntry_203A)
	$DD3A  52:          .byte < (DataTableEntry_2052)
	$DD3B  6A:          .byte < (DataTableEntry_206A)
	$DD3C  82:          .byte < (DataTableEntry_2082)
	$DD3D  9A:          .byte < (DataTableEntry_209A)
	$DD3E  BA:          .byte < (DataTableEntry_20BA)
	$DD3F  CE:          .byte < (DataTableEntry_20CE)
	$DD40  E2:          .byte < (DataTableEntry_20E2)
	$DD41  F6:          .byte < (DataTableEntry_20F6)
	$DD42  0A:          .byte < (DataTableEntry_210A)
	$DD43  1E:          .byte < (DataTableEntry_211E)
	$DD44  32:          .byte < (DataTableEntry_2132)
	$DD45  BA:          .byte < (DataTableEntry_20BA)
	$DD46  CE:          .byte < (DataTableEntry_20CE)
	$DD47  E2:          .byte < (DataTableEntry_20E2)
	$DD48  F6:          .byte < (DataTableEntry_20F6)
	$DD49  0A:          .byte < (DataTableEntry_210A)
	$DD4A  1E:          .byte < (DataTableEntry_211E)
	$DD4B  32:          .byte < (DataTableEntry_2132)
	$DD4C  46:          .byte < (DataTableEntry_2146)
	$DD4D  52:          .byte < (DataTableEntry_2152)
	$DD4E  5A:          .byte < (DataTableEntry_215A)
	$DD4F  62:          .byte < (DataTableEntry_2162)
	$DD50  6A:          .byte < (DataTableEntry_216A)
	$DD51  72:          .byte < (DataTableEntry_2172)
	$DD52  7A:          .byte < (DataTableEntry_217A)
	$DD53  46:          .byte < (DataTableEntry_2146)
	$DD54  52:          .byte < (DataTableEntry_2152)
	$DD55  5A:          .byte < (DataTableEntry_215A)
	$DD56  62:          .byte < (DataTableEntry_2162)
	$DD57  6A:          .byte < (DataTableEntry_216A)
	$DD58  72:          .byte < (DataTableEntry_2172)
	$DD59  7A:          .byte < (DataTableEntry_217A)
	$DD5A  86:          .byte < (DataTableEntry_2186)
	$DD5B  8E:          .byte < (DataTableEntry_218E)
	$DD5C  96:          .byte < (DataTableEntry_2196)
	$DD5D  9E:          .byte < (DataTableEntry_219E)
	$DD5E  A6:          .byte < (DataTableEntry_21A6)
	$DD5F  AE:          .byte < (DataTableEntry_21AE)
	$DD60  B6:          .byte < (DataTableEntry_21B6)
	$DD61  86:          .byte < (DataTableEntry_2186)
	$DD62  8E:          .byte < (DataTableEntry_218E)
	$DD63  96:          .byte < (DataTableEntry_2196)
	$DD64  9E:          .byte < (DataTableEntry_219E)
	$DD65  A6:          .byte < (DataTableEntry_21A6)
	$DD66  AE:          .byte < (DataTableEntry_21AE)
	$DD67  B6:          .byte < (DataTableEntry_21B6)
	$DD68  BE:          .byte < (DataTableEntry_21BE)
	$DD69  C2:          .byte < (DataTableEntry_21C2)
	$DD6A  C6:          .byte < (DataTableEntry_21C6)
	$DD6B  CA:          .byte < (DataTableEntry_21CA)
	$DD6C  CE:          .byte < (DataTableEntry_21CE)
	$DD6D  D2:          .byte < (DataTableEntry_21D2)
	$DD6E  D6:          .byte < (DataTableEntry_21D6)
	$DD6F  BE:          .byte < (DataTableEntry_21BE)
	$DD70  C2:          .byte < (DataTableEntry_21C2)
	$DD71  C6:          .byte < (DataTableEntry_21C6)
	$DD72  CA:          .byte < (DataTableEntry_21CA)
	$DD73  CE:          .byte < (DataTableEntry_21CE)
	$DD74  D2:          .byte < (DataTableEntry_21D2)
	$DD75  D6:          .byte < (DataTableEntry_21D6)
	$DD76  DA:          .byte < (DataTableEntry_21DA)
	$DD77  DA:          .byte < (DataTableEntry_21DA)
	$DD78  DA:          .byte < (DataTableEntry_21DA)
	$DD79  DA:          .byte < (DataTableEntry_21DA)
	$DD7A  DA:          .byte < (DataTableEntry_21DA)
	$DD7B  DA:          .byte < (DataTableEntry_21DA)
	$DD7C  DA:          .byte < (DataTableEntry_21DA)
	$DD7D  DA:          .byte < (DataTableEntry_21DA)
	$DD7E  DA:          .byte < (DataTableEntry_21DA)
	$DD7F  DA:          .byte < (DataTableEntry_21DA)
	$DD80  DA:          .byte < (DataTableEntry_21DA)
	$DD81  DA:          .byte < (DataTableEntry_21DA)
	$DD82  DA:          .byte < (DataTableEntry_21DA)
	$DD83  DA:          .byte < (DataTableEntry_21DA)
_DataPointerTableHi_1D14
	$DD84  00:          .byte > ($00)
	$DD85  DA:          .byte > (DataTableEntry_1A5C)
	$DD86  DA:          .byte > (DataTableEntry_1AA4)
	$DD87  DA:          .byte > (DataTableEntry_1AE8)
	$DD88  DB:          .byte > (DataTableEntry_1B28)
	$DD89  DB:          .byte > (DataTableEntry_1B6C)
	$DD8A  00:          .byte > ($00)
	$DD8B  00:          .byte > ($00)
	$DD8C  DB:          .byte > (DataTableEntry_1BB4)
	$DD8D  DB:          .byte > (DataTableEntry_1BFC)
	$DD8E  DC:          .byte > (DataTableEntry_1C40)
	$DD8F  DC:          .byte > (DataTableEntry_1C80)
	$DD90  DC:          .byte > (DataTableEntry_1CC4)
	$DD91  00:          .byte > ($00)
	$DD92  00:          .byte > ($00)
	$DD93  DE:          .byte > (DataTableEntry_1E3A)
	$DD94  DE:          .byte > (DataTableEntry_1E6A)
	$DD95  DE:          .byte > (DataTableEntry_1E96)
	$DD96  DE:          .byte > (DataTableEntry_1EC2)
	$DD97  DE:          .byte > (DataTableEntry_1EEE)
	$DD98  00:          .byte > ($00)
	$DD99  00:          .byte > ($00)
	$DD9A  DF:          .byte > (DataTableEntry_1F1E)
	$DD9B  DF:          .byte > (DataTableEntry_1F4E)
	$DD9C  DF:          .byte > (DataTableEntry_1F7A)
	$DD9D  DF:          .byte > (DataTableEntry_1FA6)
	$DD9E  DF:          .byte > (DataTableEntry_1FD2)
	$DD9F  00:          .byte > ($00)
	$DDA0  E0:          .byte > (DataTableEntry_2002)
	$DDA1  E0:          .byte > (DataTableEntry_2022)
	$DDA2  E0:          .byte > (DataTableEntry_203A)
	$DDA3  E0:          .byte > (DataTableEntry_2052)
	$DDA4  E0:          .byte > (DataTableEntry_206A)
	$DDA5  E0:          .byte > (DataTableEntry_2082)
	$DDA6  E0:          .byte > (DataTableEntry_209A)
	$DDA7  E0:          .byte > (DataTableEntry_2002)
	$DDA8  E0:          .byte > (DataTableEntry_2022)
	$DDA9  E0:          .byte > (DataTableEntry_203A)
	$DDAA  E0:          .byte > (DataTableEntry_2052)
	$DDAB  E0:          .byte > (DataTableEntry_206A)
	$DDAC  E0:          .byte > (DataTableEntry_2082)
	$DDAD  E0:          .byte > (DataTableEntry_209A)
	$DDAE  E0:          .byte > (DataTableEntry_20BA)
	$DDAF  E0:          .byte > (DataTableEntry_20CE)
	$DDB0  E0:          .byte > (DataTableEntry_20E2)
	$DDB1  E0:          .byte > (DataTableEntry_20F6)
	$DDB2  E1:          .byte > (DataTableEntry_210A)
	$DDB3  E1:          .byte > (DataTableEntry_211E)
	$DDB4  E1:          .byte > (DataTableEntry_2132)
	$DDB5  E0:          .byte > (DataTableEntry_20BA)
	$DDB6  E0:          .byte > (DataTableEntry_20CE)
	$DDB7  E0:          .byte > (DataTableEntry_20E2)
	$DDB8  E0:          .byte > (DataTableEntry_20F6)
	$DDB9  E1:          .byte > (DataTableEntry_210A)
	$DDBA  E1:          .byte > (DataTableEntry_211E)
	$DDBB  E1:          .byte > (DataTableEntry_2132)
	$DDBC  E1:          .byte > (DataTableEntry_2146)
	$DDBD  E1:          .byte > (DataTableEntry_2152)
	$DDBE  E1:          .byte > (DataTableEntry_215A)
	$DDBF  E1:          .byte > (DataTableEntry_2162)
	$DDC0  E1:          .byte > (DataTableEntry_216A)
	$DDC1  E1:          .byte > (DataTableEntry_2172)
	$DDC2  E1:          .byte > (DataTableEntry_217A)
	$DDC3  E1:          .byte > (DataTableEntry_2146)
	$DDC4  E1:          .byte > (DataTableEntry_2152)
	$DDC5  E1:          .byte > (DataTableEntry_215A)
	$DDC6  E1:          .byte > (DataTableEntry_2162)
	$DDC7  E1:          .byte > (DataTableEntry_216A)
	$DDC8  E1:          .byte > (DataTableEntry_2172)
	$DDC9  E1:          .byte > (DataTableEntry_217A)
	$DDCA  E1:          .byte > (DataTableEntry_2186)
	$DDCB  E1:          .byte > (DataTableEntry_218E)
	$DDCC  E1:          .byte > (DataTableEntry_2196)
	$DDCD  E1:          .byte > (DataTableEntry_219E)
	$DDCE  E1:          .byte > (DataTableEntry_21A6)
	$DDCF  E1:          .byte > (DataTableEntry_21AE)
	$DDD0  E1:          .byte > (DataTableEntry_21B6)
	$DDD1  E1:          .byte > (DataTableEntry_2186)
	$DDD2  E1:          .byte > (DataTableEntry_218E)
	$DDD3  E1:          .byte > (DataTableEntry_2196)
	$DDD4  E1:          .byte > (DataTableEntry_219E)
	$DDD5  E1:          .byte > (DataTableEntry_21A6)
	$DDD6  E1:          .byte > (DataTableEntry_21AE)
	$DDD7  E1:          .byte > (DataTableEntry_21B6)
	$DDD8  E1:          .byte > (DataTableEntry_21BE)
	$DDD9  E1:          .byte > (DataTableEntry_21C2)
	$DDDA  E1:          .byte > (DataTableEntry_21C6)
	$DDDB  E1:          .byte > (DataTableEntry_21CA)
	$DDDC  E1:          .byte > (DataTableEntry_21CE)
	$DDDD  E1:          .byte > (DataTableEntry_21D2)
	$DDDE  E1:          .byte > (DataTableEntry_21D6)
	$DDDF  E1:          .byte > (DataTableEntry_21BE)
	$DDE0  E1:          .byte > (DataTableEntry_21C2)
	$DDE1  E1:          .byte > (DataTableEntry_21C6)
	$DDE2  E1:          .byte > (DataTableEntry_21CA)
	$DDE3  E1:          .byte > (DataTableEntry_21CE)
	$DDE4  E1:          .byte > (DataTableEntry_21D2)
	$DDE5  E1:          .byte > (DataTableEntry_21D6)
	$DDE6  E1:          .byte > (DataTableEntry_21DA)
	$DDE7  E1:          .byte > (DataTableEntry_21DA)
	$DDE8  E1:          .byte > (DataTableEntry_21DA)
	$DDE9  E1:          .byte > (DataTableEntry_21DA)
	$DDEA  E1:          .byte > (DataTableEntry_21DA)
	$DDEB  E1:          .byte > (DataTableEntry_21DA)
	$DDEC  E1:          .byte > (DataTableEntry_21DA)
	$DDED  E1:          .byte > (DataTableEntry_21DA)
	$DDEE  E1:          .byte > (DataTableEntry_21DA)
	$DDEF  E1:          .byte > (DataTableEntry_21DA)
	$DDF0  E1:          .byte > (DataTableEntry_21DA)
	$DDF1  E1:          .byte > (DataTableEntry_21DA)
	$DDF2  E1:          .byte > (DataTableEntry_21DA)
	$DDF3  E1:          .byte > (DataTableEntry_21DA)
_data_1DF4_indexed
	$DDF4               .byte $00,$30,$2C
_data_1DF7_indexed
	$DDF7               .byte $30,$2C,$30,$00,$00,$30,$2C,$30,$2C,$30,$00,$00,$30,$2C,$2C,$2C
	$DE07               .byte $30,$00,$00,$30,$2C,$2C,$2C,$30,$00,$20,$18,$18,$18,$18,$18,$20
	$DE17               .byte $20,$18,$18,$18,$18,$18,$20
_data_1E1E_indexed
	$DE1E               .byte $00,$48,$44
_data_1E21_indexed
	$DE21               .byte $40,$44,$48,$00,$00,$48,$44,$40,$44,$48,$00
_data_1E2C_indexed
	$DE2C               .byte $00,$3C,$38,$38,$38,$3C,$00,$00,$3C,$38,$38,$38,$3C,$00
DataTableEntry_1E3A
	$DE3A               .byte $08,$58,$40,$F0,$08,$57,$40,$F8,$08,$56,$40,$00,$10,$5D,$40,$EC
	$DE4A               .byte $10,$5C,$40,$F4,$10,$5B,$40,$FC,$10,$5A,$40,$04,$10,$59,$40,$0C
	$DE5A               .byte $18,$61,$40,$F4,$18,$60,$40,$FC,$18,$5F,$40,$04,$18,$5E,$40,$0C
DataTableEntry_1E6A
	$DE6A               .byte $08,$4A,$40,$F1,$08,$49,$40,$F9,$08,$48,$40,$01,$10,$4E,$40,$F1
	$DE7A               .byte $10,$4D,$40,$F9,$10,$4C,$40,$01,$10,$4B,$40,$09,$18,$52,$40,$F1
	$DE8A               .byte $18,$51,$40,$F9,$18,$50,$40,$01,$18,$4F,$40,$09
DataTableEntry_1E96
	$DE96               .byte $08,$40,$00,$F4,$08,$41,$00,$FC,$08,$40,$40,$04,$10,$42,$00,$F0
	$DEA6               .byte $10,$43,$00,$F8,$10,$43,$40,$00,$10,$42,$40,$08,$18,$44,$00,$F0
	$DEB6               .byte $18,$45,$00,$F8,$18,$45,$40,$00,$18,$44,$40,$08
DataTableEntry_1EC2
	$DEC2               .byte $08,$48,$00,$F7,$08,$49,$00,$FF,$08,$4A,$00,$07,$10,$4B,$00,$EF
	$DED2               .byte $10,$4C,$00,$F7,$10,$4D,$00,$FF,$10,$4E,$00,$07,$18,$4F,$00,$EF
	$DEE2               .byte $18,$50,$00,$F7,$18,$51,$00,$FF,$18,$52,$00,$07
DataTableEntry_1EEE
	$DEEE               .byte $08,$56,$00,$F8,$08,$57,$00,$00,$08,$58,$00,$08,$10,$59,$00,$EC
	$DEFE               .byte $10,$5A,$00,$F4,$10,$5B,$00,$FC,$10,$5C,$00,$04,$10,$5D,$00,$0C
	$DF0E               .byte $18,$5E,$00,$EC,$18,$5F,$00,$F4,$18,$60,$00,$FC,$18,$61,$00,$04
DataTableEntry_1F1E
	$DF1E               .byte $08,$58,$40,$F0,$08,$57,$40,$F8,$08,$56,$40,$00,$10,$5D,$40,$EC
	$DF2E               .byte $10,$5C,$40,$F4,$10,$5B,$40,$FC,$10,$5A,$40,$04,$10,$59,$40,$0C
	$DF3E               .byte $18,$64,$40,$F4,$18,$63,$40,$FC,$18,$5F,$40,$04,$18,$62,$40,$0C
DataTableEntry_1F4E
	$DF4E               .byte $08,$4A,$40,$F1,$08,$49,$40,$F9,$08,$48,$40,$01,$10,$4E,$40,$F1
	$DF5E               .byte $10,$4D,$40,$F9,$10,$4C,$40,$01,$10,$4B,$40,$09,$18,$54,$40,$F1
	$DF6E               .byte $18,$51,$40,$F9,$18,$50,$40,$01,$18,$53,$40,$09
DataTableEntry_1F7A
	$DF7A               .byte $08,$40,$00,$F4,$08,$41,$00,$FC,$08,$40,$40,$04,$10,$42,$00,$F0
	$DF8A               .byte $10,$43,$00,$F8,$10,$43,$40,$00,$10,$42,$40,$08,$18,$44,$00,$F0
	$DF9A               .byte $18,$45,$00,$F8,$18,$45,$40,$00,$18,$44,$40,$08
DataTableEntry_1FA6
	$DFA6               .byte $08,$48,$00,$F7,$08,$49,$00,$FF,$08,$4A,$00,$07,$10,$4B,$00,$EF
	$DFB6               .byte $10,$4C,$00,$F7,$10,$4D,$00,$FF,$10,$4E,$00,$07,$18,$53,$00,$EF
	$DFC6               .byte $18,$50,$00,$F7,$18,$51,$00,$FF,$18,$54,$00,$07
DataTableEntry_1FD2
	$DFD2               .byte $08,$56,$00,$F8,$08,$57,$00,$00,$08,$58,$00,$08,$10,$59,$00,$EC
	$DFE2               .byte $10,$5A,$00,$F4,$10,$5B,$00,$FC,$10,$5C,$00,$04,$10,$5D,$00,$0C
	$DFF2               .byte $18,$62,$00,$EC,$18,$5F,$00,$F4,$18,$63,$00,$FC,$18,$64,$00
DataTableEntry_2001
	$E001               .byte $04
DataTableEntry_2002
	$E002               .byte $10,$78,$40,$F0,$10,$77,$40,$F8,$10,$76,$40,$00,$10,$75,$40,$08
	$E012               .byte $18,$7C,$40,$F0,$18,$7B,$40,$F8,$18,$7A,$40,$00,$18,$79,$40,$08
DataTableEntry_2022
	$E022               .byte $10,$71,$40,$F2,$10
_data_2027
	$E027               .byte $70,$40,$FA,$10,$6F,$40,$02,$18,$74,$40,$F6,$18,$73,$40,$FE,$18
	$E037               .byte $72,$40,$06
DataTableEntry_203A
	$E03A               .byte $10,$6B,$40,$F4,$10,$6A,$40,$FC,$10,$69,$40,$04,$18,$6E,$40,$F4
	$E04A               .byte $18,$6D,$40,$FC,$18,$6C,$40,$04
DataTableEntry_2052
	$E052               .byte $10,$65,$00,$F4,$10,$66,$00,$FC,$10,$65,$40,$04,$18,$67,$00,$F4
	$E062               .byte $18,$68,$00,$FC,$18,$67,$40,$04
DataTableEntry_206A
	$E06A               .byte $10,$69,$00,$F4,$10,$6A,$00,$FC,$10,$6B,$00,$04,$18,$6C,$00,$F4
	$E07A               .byte $18,$6D,$00,$FC,$18,$6E,$00,$04
DataTableEntry_2082
	$E082               .byte $10,$6F,$00,$F6,$10,$70,$00,$FD,$10,$71,$00,$06,$18,$72,$00,$F2
	$E092               .byte $18,$73,$00,$FA,$18,$74,$00,$02
DataTableEntry_209A
	$E09A               .byte $10,$75,$00,$F0,$10,$76,$00,$F8,$10,$77,$00,$00,$10,$78,$00,$08
	$E0AA               .byte $18,$79,$00,$F0,$18,$7A,$00,$F8,$18,$7B,$00,$00,$18,$7C,$00,$08
DataTableEntry_20BA
	$E0BA               .byte $10,$8C,$40,$FC,$10,$8B,$40,$04,$18,$90,$40,$F4,$18,$8F,$40,$FC
	$E0CA               .byte $18,$8E,$40,$04
DataTableEntry_20CE
	$E0CE               .byte $10,$87,$40,$F4,$10,$86,$40,$FC,$18,$8A,$40,$F4,$18,$89,$40,$FC
	$E0DE               .byte $18,$88,$40,$04
DataTableEntry_20E2
	$E0E2               .byte $10,$81,$40,$F8,$10,$80,$40,$00,$18,$84,$40,$F4,$18,$83,$40,$FC
	$E0F2               .byte $18,$82,$40,$04
DataTableEntry_20F6
	$E0F6               .byte $10,$7D,$00,$F8,$10,$7D,$40,$00,$18,$7E,$00,$F4,$18,$7F,$00,$FC
	$E106               .byte $18,$7E,$40,$04
DataTableEntry_210A
	$E10A               .byte $10,$80,$00,$F8,$10,$81,$00,$00,$18,$82,$00,$F4,$18,$83,$00,$FC
	$E11A               .byte $18,$84,$00,$04
DataTableEntry_211E
	$E11E               .byte $10,$86,$00,$FC,$10,$87,$00,$04,$18,$88,$00,$F4,$18,$89,$00,$FC
	$E12E               .byte $18,$8A,$00,$04
DataTableEntry_2132
	$E132               .byte $10,$8B,$00,$F4,$10,$8C,$00,$FC,$18,$8E,$00,$F4,$18,$8F,$00,$FC
	$E142               .byte $18,$90,$00,$04
DataTableEntry_2146
	$E146               .byte $18,$99,$40,$F4,$18,$98,$40,$FC,$18,$97,$40,$04
DataTableEntry_2152
	$E152               .byte $18,$96,$40,$F7,$18,$95,$40,$FF
DataTableEntry_215A
	$E15A               .byte $18,$94,$40,$F8,$18,$93,$40,$00
DataTableEntry_2162
	$E162               .byte $18,$92,$00,$F8,$18,$92,$40,$00
DataTableEntry_216A
	$E16A               .byte $18,$93,$00,$F8,$18,$94,$00,$00
DataTableEntry_2172
	$E172               .byte $18,$95,$00,$F9,$18,$96,$00,$01
DataTableEntry_217A
	$E17A               .byte $18,$97,$00,$F4,$18,$98,$00,$FC,$18,$99,$00,$04
DataTableEntry_2186
	$E186               .byte $18,$A0,$40,$F8,$18,$9F,$40,$00
DataTableEntry_218E
	$E18E               .byte $18,$9E,$40,$F8,$18,$9D,$40,$00
DataTableEntry_2196
	$E196               .byte $18,$9C,$40,$F8,$18,$9B,$40,$00
DataTableEntry_219E
	$E19E               .byte $18,$9A,$00,$F8,$18,$9A,$40,$00
DataTableEntry_21A6
	$E1A6               .byte $18,$9B,$00,$F8,$18,$9C,$00,$00
DataTableEntry_21AE
	$E1AE               .byte $18,$9D,$00,$F8,$18,$9E,$00,$00
DataTableEntry_21B6
	$E1B6               .byte $18,$9F,$00,$F8,$18,$A0,$00,$00
DataTableEntry_21BE
	$E1BE               .byte $18,$A4,$40,$FC
DataTableEntry_21C2
	$E1C2               .byte $18,$A3,$40,$FC
DataTableEntry_21C6
	$E1C6               .byte $18,$A2,$40,$FC
DataTableEntry_21CA
	$E1CA               .byte $18,$A1,$00,$FC
DataTableEntry_21CE
	$E1CE               .byte $18,$A2,$00,$FC
DataTableEntry_21D2
	$E1D2               .byte $18,$A3,$00,$FC
DataTableEntry_21D6
	$E1D6               .byte $18,$A4,$00,$FC
DataTableEntry_21DA
	$E1DA               .byte $18,$A5,$00,$FC
_loc_21DE
	$E1DE  A5 50:       lda $50
	$E1E0  85 1F:       sta $1F
	$E1E2  A5 51:       lda $51
	$E1E4  0A:          asl a
	$E1E5  26 1F:       rol $1F
	$E1E7  0A:          asl a
	$E1E8  26 1F:       rol $1F
	$E1EA  85 1E:       sta $1E
	$E1EC  38:          sec 
	$E1ED  E9 20:       sbc #$20
	$E1EF  85 1E:       sta $1E
	$E1F1  A5 1F:       lda $1F
	$E1F3  E9 03:       sbc #$03
	$E1F5  85 1F:       sta $1F
	$E1F7  A2 02:       ldx #$02
-	$E1F9  B5 8F:       lda $8F,x
	$E1FB  C9 F0:       cmp #$F0
	$E1FD  B0 03:       bcs +		; $E202
	$E1FF  4C AA E2:    jmp +++		; $E2AA

+	$E202  A9 F8:       lda #$F8
	$E204  95 8F:       sta $8F,x
	$E206  A9 80:       lda #$80
	$E208  95 92:       sta $92,x
	$E20A  20 6B E9:    jsr _func_296B
	$E20D  A5 2E:       lda $2E
	$E20F  29 01:       and #$01
	$E211  18:          clc 
	$E212  69 01:       adc #$01
	$E214  95 9B:       sta $9B,x
	$E216  A5 2E:       lda $2E
	$E218  29 0F:       and #$0F
	$E21A  4A:          lsr a
	$E21B  95 95:       sta $95,x
	$E21D  A5 1F:       lda $1F
	$E21F  30 30:       bmi ++		; $E251
	$E221  A5 8F:       lda $8F
	$E223  C9 30:       cmp #$30
	$E225  B0 03:       bcs +		; $E22A
	$E227  4C 00 E3:    jmp ++++		; $E300

+	$E22A  A5 90:       lda $90
	$E22C  C9 30:       cmp #$30
	$E22E  B0 03:       bcs +		; $E233
	$E230  4C 00 E3:    jmp ++++		; $E300

+	$E233  A5 91:       lda $91
	$E235  C9 30:       cmp #$30
	$E237  B0 03:       bcs +		; $E23C
	$E239  4C 00 E3:    jmp ++++		; $E300

+	$E23C  20 81 E9:    jsr _func_2981
	$E23F  A5 30:       lda $30
	$E241  29 1F:       and #$1F
	$E243  F0 03:       beq +		; $E248
	$E245  4C 00 E3:    jmp ++++		; $E300

+	$E248  A9 00:       lda #$00
	$E24A  95 8F:       sta $8F,x
	$E24C  95 92:       sta $92,x
	$E24E  4C 00 E3:    jmp ++++		; $E300

++	$E251  A5 8F:       lda $8F
	$E253  C9 F0:       cmp #$F0
	$E255  B0 07:       bcs +		; $E25E
	$E257  C9 60:       cmp #$60
	$E259  90 03:       bcc +		; $E25E
	$E25B  4C 00 E3:    jmp ++++		; $E300

+	$E25E  A5 90:       lda $90
	$E260  C9 F0:       cmp #$F0
	$E262  B0 07:       bcs +		; $E26B
	$E264  C9 60:       cmp #$60
	$E266  90 03:       bcc +		; $E26B
	$E268  4C 00 E3:    jmp ++++		; $E300

+	$E26B  A5 91:       lda $91
	$E26D  C9 F0:       cmp #$F0
	$E26F  B0 07:       bcs +		; $E278
	$E271  C9 60:       cmp #$60
	$E273  90 03:       bcc +		; $E278
	$E275  4C 00 E3:    jmp ++++		; $E300

+	$E278  A5 56:       lda $56
	$E27A  05 5A:       ora $5A
	$E27C  D0 0E:       bne +		; $E28C -> $E300
	$E27E  A5 74:       lda $74
	$E280  D0 0A:       bne +		; $E28C -> $E300
	$E282  A5 34:       lda $34
	$E284  F0 06:       beq +		; $E28C -> $E300
	$E286  A5 9E:       lda $9E
	$E288  F0 05:       beq ++		; $E28F
	$E28A  C6 9E:       dec $9E
+	$E28C  4C 00 E3:    jmp ++++		; $E300

++	$E28F  B5 95:       lda $95,x
	$E291  C9 04:       cmp #$04
	$E293  B0 6B:       bcs ++++		; $E300
	$E295  20 81 E9:    jsr _func_2981
	$E298  A5 30:       lda $30
	$E29A  D0 64:       bne ++++		; $E300
	$E29C  A5 31:       lda $31
	$E29E  29 01:       and #$01
	$E2A0  D0 5E:       bne ++++		; $E300
	$E2A2  A9 EF:       lda #$EF
	$E2A4  95 8F:       sta $8F,x
	$E2A6  95 92:       sta $92,x
	$E2A8  D0 56:       bne ++++		; $E300

+++	$E2AA  B5 92:       lda $92,x
	$E2AC  18:          clc 
	$E2AD  65 1E:       adc $1E
	$E2AF  95 92:       sta $92,x
	$E2B1  B5 8F:       lda $8F,x
	$E2B3  65 1F:       adc $1F
	$E2B5  95 8F:       sta $8F,x
	$E2B7  B5 9B:       lda $9B,x
	$E2B9  F0 45:       beq ++++		; $E300
	$E2BB  B5 95:       lda $95,x
	$E2BD  C5 B0:       cmp $B0
	$E2BF  B0 04:       bcs +		; $E2C5
	$E2C1  A9 38:       lda #$38
	$E2C3  D0 39:       bne +++		; $E2FE

+	$E2C5  C5 B1:       cmp $B1
	$E2C7  B0 04:       bcs +		; $E2CD
	$E2C9  A9 C8:       lda #$C8
	$E2CB  D0 31:       bne +++		; $E2FE

+	$E2CD  B5 8F:       lda $8F,x
	$E2CF  30 02:       bmi +		; $E2D3
	$E2D1  F6 98:       inc $98,x
+	$E2D3  B5 98:       lda $98,x
	$E2D5  25 B2:       and $B2
	$E2D7  D0 14:       bne ++		; $E2ED
	$E2D9  B5 8C:       lda $8C,x
	$E2DB  30 08:       bmi +		; $E2E5
	$E2DD  C9 38:       cmp #$38
	$E2DF  90 04:       bcc +		; $E2E5
	$E2E1  A9 38:       lda #$38
	$E2E3  D0 19:       bne +++		; $E2FE

+	$E2E5  B5 8C:       lda $8C,x
	$E2E7  18:          clc 
	$E2E8  69 07:       adc #$07
	$E2EA  4C FE E2:    jmp +++		; $E2FE

++	$E2ED  B5 8C:       lda $8C,x
	$E2EF  10 08:       bpl +		; $E2F9
	$E2F1  C9 C9:       cmp #$C9
	$E2F3  B0 04:       bcs +		; $E2F9
	$E2F5  A9 C8:       lda #$C8
	$E2F7  D0 05:       bne +++		; $E2FE

+	$E2F9  B5 8C:       lda $8C,x
	$E2FB  38:          sec 
	$E2FC  E9 07:       sbc #$07
+++	$E2FE  95 8C:       sta $8C,x
++++	$E300  B5 8F:       lda $8F,x
	$E302  4A:          lsr a
	$E303  4A:          lsr a
	$E304  4A:          lsr a
	$E305  A8:          tay 
	$E306  B9 49 E5:    lda _data_2549_indexed,y
	$E309  95 80:       sta $80,x
	$E30B  B4 8F:       ldy $8F,x
	$E30D  B9 49 E4:    lda _data_2449_indexed,y
	$E310  95 89:       sta $89,x
	$E312  38:          sec 
	$E313  E9 50:       sbc #$50
	$E315  C9 80:       cmp #$80
	$E317  90 02:       bcc +		; $E31B
	$E319  A9 7F:       lda #$7F
+	$E31B  A8:          tay 
	$E31C  A9 7E:       lda #$7E
	$E31E  38:          sec 
	$E31F  F1 3A:       sbc ($3A),y
	$E321  0A:          asl a
	$E322  95 83:       sta $83,x
	$E324  A9 00:       lda #$00
	$E326  69 00:       adc #$00
	$E328  95 86:       sta $86,x
	$E32A  A9 03:       lda #$03
	$E32C  95 7D:       sta $7D,x
	$E32E  B5 89:       lda $89,x
	$E330  38:          sec 
	$E331  E9 50:       sbc #$50
	$E333  85 1C:       sta $1C
	$E335  A8:          tay 
	$E336  B9 69 E5:    lda _data_2569_indexed,y
	$E339  85 9F:       sta $9F
	$E33B  A9 00:       lda #$00
	$E33D  85 1B:       sta $1B
	$E33F  B5 8C:       lda $8C,x
	$E341  10 07:       bpl +		; $E34A
	$E343  E6 1B:       inc $1B
	$E345  49 FF:       eor #$FF
	$E347  18:          clc 
	$E348  69 01:       adc #$01
+	$E34A  85 A1:       sta $A1
	$E34C  A0 06:       ldy #$06
	$E34E  20 99 E9:    jsr _func_2999
	$E351  A5 1B:       lda $1B
	$E353  F0 10:       beq +		; $E365
	$E355  B5 83:       lda $83,x
	$E357  38:          sec 
	$E358  E5 A3:       sbc $A3
	$E35A  95 83:       sta $83,x
	$E35C  B5 86:       lda $86,x
	$E35E  E9 00:       sbc #$00
	$E360  95 86:       sta $86,x
	$E362  4C 72 E3:    jmp ++		; $E372

+	$E365  B5 83:       lda $83,x
	$E367  18:          clc 
	$E368  65 A3:       adc $A3
	$E36A  95 83:       sta $83,x
	$E36C  B5 86:       lda $86,x
	$E36E  69 00:       adc #$00
	$E370  95 86:       sta $86,x
++	$E372  A4 1C:       ldy $1C
	$E374  C0 70:       cpy #$70
	$E376  90 04:       bcc +		; $E37C
	$E378  A9 03:       lda #$03
	$E37A  D0 27:       bne ++		; $E3A3

+	$E37C  B1 3A:       lda ($3A),y
	$E37E  88:          dey 
	$E37F  88:          dey 
	$E380  88:          dey 
	$E381  88:          dey 
	$E382  38:          sec 
	$E383  F1 3A:       sbc ($3A),y
	$E385  85 1D:       sta $1D
	$E387  B1 3A:       lda ($3A),y
	$E389  88:          dey 
	$E38A  88:          dey 
	$E38B  88:          dey 
	$E38C  88:          dey 
	$E38D  38:          sec 
	$E38E  F1 3A:       sbc ($3A),y
	$E390  18:          clc 
	$E391  65 1D:       adc $1D
	$E393  18:          clc 
	$E394  69 80:       adc #$80
	$E396  4A:          lsr a
	$E397  4A:          lsr a
	$E398  38:          sec 
	$E399  E9 20:       sbc #$20
	$E39B  10 03:       bpl +		; $E3A0
	$E39D  18:          clc 
	$E39E  69 01:       adc #$01
+	$E3A0  18:          clc 
	$E3A1  75 7D:       adc $7D,x
++	$E3A3  20 2A E4:    jsr _func_242A
	$E3A6  A5 1C:       lda $1C
	$E3A8  C9 30:       cmp #$30
	$E3AA  90 2D:       bcc +++		; $E3D9
	$E3AC  E9 30:       sbc #$30
	$E3AE  4A:          lsr a
	$E3AF  4A:          lsr a
	$E3B0  4A:          lsr a
	$E3B1  85 A1:       sta $A1
	$E3B3  A0 03:       ldy #$03
	$E3B5  B5 83:       lda $83,x
	$E3B7  30 0C:       bmi +		; $E3C5
	$E3B9  49 7F:       eor #$7F
	$E3BB  85 9F:       sta $9F
	$E3BD  20 99 E9:    jsr _func_2999
	$E3C0  A5 A3:       lda $A3
	$E3C2  4C D3 E3:    jmp ++		; $E3D3

+	$E3C5  49 80:       eor #$80
	$E3C7  85 9F:       sta $9F
	$E3C9  20 99 E9:    jsr _func_2999
	$E3CC  A5 A3:       lda $A3
	$E3CE  49 FF:       eor #$FF
	$E3D0  18:          clc 
	$E3D1  69 01:       adc #$01
++	$E3D3  18:          clc 
	$E3D4  75 7D:       adc $7D,x
	$E3D6  20 2A E4:    jsr _func_242A
+++	$E3D9  A5 56:       lda $56
	$E3DB  05 5A:       ora $5A
	$E3DD  D0 1B:       bne +		; $E3FA
	$E3DF  B5 8F:       lda $8F,x
	$E3E1  C9 F0:       cmp #$F0
	$E3E3  B0 15:       bcs +		; $E3FA
	$E3E5  B5 89:       lda $89,x
	$E3E7  38:          sec 
	$E3E8  E9 A5:       sbc #$A5
	$E3EA  C9 28:       cmp #$28
	$E3EC  B0 0C:       bcs +		; $E3FA
	$E3EE  B5 83:       lda $83,x
	$E3F0  38:          sec 
	$E3F1  E9 63:       sbc #$63
	$E3F3  C9 3C:       cmp #$3C
	$E3F5  B0 03:       bcs +		; $E3FA
	$E3F7  20 0D E4:    jsr _func_240D
+	$E3FA  CA:          dex 
	$E3FB  30 03:       bmi +		; $E400
	$E3FD  4C F9 E1:    jmp -		; $E1F9

+	$E400  E6 35:       inc $35
	$E402  A5 35:       lda $35
	$E404  C9 03:       cmp #$03
	$E406  90 04:       bcc +		; $E40C -> rts
	$E408  A9 00:       lda #$00
	$E40A  85 35:       sta $35
+	$E40C  60:          rts 
;------------------------------------------
_func_240D
	$E40D  A5 34:       lda $34
	$E40F  F0 18:       beq ++		; $E429 -> rts
	$E411  E6 56:       inc $56
	$E413  A9 00:       lda #$00
	$E415  85 53:       sta $53
	$E417  A5 50:       lda $50
	$E419  D0 06:       bne +		; $E421
	$E41B  A5 51:       lda $51
	$E41D  C9 C8:       cmp #$C8
	$E41F  90 08:       bcc ++		; $E429 -> rts
+	$E421  A9 00:       lda #<_data_0800
	$E423  85 50:       sta $50
	$E425  A9 C8:       lda #>_data_0800
	$E427  85 51:       sta $51
++	$E429  60:          rts 
;------------------------------------------
_func_242A
	$E42A  10 02:       bpl +		; $E42E
	$E42C  A9 00:       lda #$00
+	$E42E  C9 06:       cmp #$06
	$E430  90 02:       bcc +		; $E434
	$E432  A9 06:       lda #$06
+	$E434  95 7D:       sta $7D,x
	$E436  B4 80:       ldy $80,x
	$E438  C0 07:       cpy #$07
	$E43A  90 0C:       bcc ++		; $E448 -> rts
	$E43C  C9 00:       cmp #$00
	$E43E  D0 02:       bne +		; $E442
	$E440  F6 7D:       inc $7D,x
+	$E442  C9 06:       cmp #$06
	$E444  D0 02:       bne ++		; $E448 -> rts
	$E446  D6 7D:       dec $7D,x
++	$E448  60:          rts 
;------------------------------------------
_data_2449_indexed
	$E449               .byte $54,$54,$54,$54,$54,$54,$54,$54,$55,$55,$55,$55,$55,$55,$55,$55
	$E459               .byte $55,$55,$55,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57,$57
	$E469               .byte $57,$57,$57,$57,$57,$57,$57,$57,$58,$58,$58,$58,$58,$58,$59,$59
	$E479               .byte $59,$59,$59,$5A,$5A,$5A,$5A,$5A,$5B,$5B,$5B,$5C,$5C,$5C,$5C,$5D
	$E489               .byte $5D,$5D,$5E,$5E,$5E,$5F,$5F,$5F,$5F,$60,$60,$60,$61,$61,$61,$62
	$E499               .byte $62,$62,$63,$63,$63,$64,$64,$65,$65,$65,$66,$66,$66,$67,$67,$67
	$E4A9               .byte $68,$68,$69,$69,$69,$6A,$6A,$6A,$6B,$6B,$6C,$6C,$6C,$6D,$6D,$6E
	$E4B9               .byte $6E,$70,$70,$70,$71,$71,$72,$72,$73,$73,$73,$74,$74,$75,$75,$76
	$E4C9               .byte $76,$77,$77,$77,$78,$78,$79,$79,$7A,$7A,$7B,$7B,$7C,$7C,$7D,$7D
	$E4D9               .byte $7E,$7F,$7F,$80,$80,$81,$81,$82,$82,$83,$84,$84,$85,$85,$86,$86
	$E4E9               .byte $87,$88,$88,$89,$89,$8A,$8B,$8B,$8C,$8D,$8D,$8E,$8F,$90,$90,$91
	$E4F9               .byte $92,$93,$94,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$A0,$A1
	$E509               .byte $A2,$A3,$A4,$A6,$A7,$A8,$A9,$AB,$AC,$AD,$AF,$B0,$B1,$B3,$B4,$B6
	$E519               .byte $B7,$B9,$BB,$BC,$BE,$C0,$C1,$C3,$C5,$C7,$C8,$CA,$CC,$CE,$D0,$D2
	$E529               .byte $D4,$D6,$D8,$DA,$DC,$DE,$E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE,$F0,$F0
	$E539               .byte $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
_data_2549_indexed
	$E549               .byte $01,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$04,$04,$04,$04,$05
	$E559               .byte $05,$05,$06,$06,$06,$07,$07,$07,$08,$08,$08,$08,$08,$08,$00,$00
_data_2569_indexed
	$E569               .byte $0A,$0C,$0E,$10,$12,$14,$16,$18,$1A,$1C,$1E,$20,$22,$24,$26,$28
	$E579               .byte $29,$2B,$2C,$2E,$2F,$31,$32,$34,$35,$37,$38,$3A,$3B,$3D,$3E,$40
	$E589               .byte $41,$43,$44,$46,$47,$49,$4A,$4C,$4D,$4F,$50,$52,$53,$55,$56,$58
	$E599               .byte $59,$5B,$5C,$5E,$5F,$61,$62,$64,$65,$67,$68,$6A,$6B,$6D,$6E,$70
	$E5A9               .byte $71,$73,$74,$76,$77,$79,$7A,$7C,$7D,$7F,$80,$82,$83,$85,$86,$88
	$E5B9               .byte $89,$8B,$8C,$8E,$8F,$91,$92,$94,$95,$97,$98,$9A,$9B,$9D,$9E,$A0
	$E5C9               .byte $A1,$A3,$A4,$A6,$A7,$A9,$AA,$AC,$AD,$AF,$B0,$B2,$B3,$B5,$B6,$B8
	$E5D9               .byte $B9,$BB,$BC,$BE,$BF,$C1,$C2,$C4,$C5,$C7,$C8,$CA,$CB,$CD,$CE,$D0
	$E5E9               .byte $D1,$D3,$D4,$D6,$D7,$D9,$DA,$DC,$DD,$DF,$E0,$E2,$E3,$E5,$E6,$E8
	$E5F9               .byte $E9,$EB,$EC,$EE,$EF,$F1,$F2,$F4,$F5,$F7,$F8,$FA,$FB,$FD,$FE,$FF
	$E609               .byte $FF
_main_reset_code
	$E60A  A9 01:       lda #$01
	$E60C  85 2A:       sta $2A
	$E60E  20 6E F3:    jsr _cleanNT_OAM
	$E611  20 6E F4:    jsr _soundPrepare
	$E614  A0 00:       ldy #$00
	$E616  84 4F:       sty 程序及卡通定义页选择控制器
	$E618  C8:          iny 
	$E619  84 71:       sty 游戏演示标志
	$E61B  A9 FF:       lda #$FF
	$E61D  20 8E F4:    jsr _setLevelSoundData
	$E620  20 05 F5:    jsr _LevelSoundPlay
	$E623  20 1B C9:    jsr _queryKeyInput
	$E626  A5 14:       lda ppuctrl_state
	$E628  8D 00 20:    sta PPUCTRL
	$E62B  A9 20:       lda #$20
	$E62D  A0 40:       ldy #$40
	$E62F  20 64 E9:    jsr _func_2964
	$E632  A0 00:       ldy #$00
--	$E634  B9 6D E8:    lda _data_286D_indexed,y
	$E637  F0 22:       beq _loc_265B
	$E639  C9 20:       cmp #$20
	$E63B  B0 18:       bcs +++		; $E655
	$E63D  29 0F:       and #$0F
	$E63F  AA:          tax 
	$E640  B9 6D E8:    lda _data_286D_indexed,y
	$E643  29 10:       and #$10
	$E645  D0 04:       bne +		; $E64B
	$E647  A9 2D:       lda #$2D
	$E649  D0 02:       bne ++		; $E64D

+	$E64B  A9 2E:       lda #$2E
++ -	$E64D  8D 07 20:    sta PPUDATA
	$E650  CA:          dex 
	$E651  10 FA:       bpl -		; $E64D
	$E653  30 03:       bmi ++++		; $E658
+++	$E655  8D 07 20:    sta PPUDATA
++++	$E658  C8:          iny 
	$E659  D0 D9:       bne --		; $E634
_loc_265B
	$E65B  20 1B C9:    jsr _queryKeyInput
	$E65E  A9 22:       lda #$22
	$E660  A0 0A:       ldy #$0A
	$E662  A2 01:       ldx #$01
	$E664  20 12 E8:    jsr _func_2812
	$E667  A9 22:       lda #$22
	$E669  A0 4A:       ldy #$4A
	$E66B  E8:          inx 
	$E66C  20 12 E8:    jsr _func_2812
	$E66F  A9 22:       lda #$22
	$E671  A0 8A:       ldy #$8A
	$E673  E8:          inx 
	$E674  20 12 E8:    jsr _func_2812
	$E677  A9 24:       lda #$24
	$E679  A0 60:       ldy #$60
	$E67B  84 17:       sty $17
	$E67D  20 64 E9:    jsr _func_2964
	$E680  A0 7F:       ldy #$7F
-	$E682  A5 17:       lda $17
	$E684  29 01:       and #$01
	$E686  49 01:       eor #$01
	$E688  85 17:       sta $17
	$E68A  0A:          asl a
	$E68B  69 2D:       adc #$2D
	$E68D  8D 07 20:    sta PPUDATA
	$E690  98:          tya 
	$E691  29 1F:       and #$1F
	$E693  D0 02:       bne +		; $E697
	$E695  E6 17:       inc $17
+	$E697  88:          dey 
	$E698  10 E8:       bpl -		; $E682
	$E69A  A9 23:       lda #$23
	$E69C  A0 C0:       ldy #$C0
	$E69E  20 64 E9:    jsr _func_2964
	$E6A1  A0 00:       ldy #$00
--	$E6A3  B9 0E E9:    lda _data_290E_indexed,y
	$E6A6  A2 07:       ldx #$07
-	$E6A8  8D 07 20:    sta PPUDATA
	$E6AB  CA:          dex 
	$E6AC  10 FA:       bpl -		; $E6A8
	$E6AE  C8:          iny 
	$E6AF  C0 08:       cpy #$08
	$E6B1  90 F0:       bcc --		; $E6A3
	$E6B3  A9 27:       lda #$27
	$E6B5  A0 C0:       ldy #$C0
	$E6B7  20 64 E9:    jsr _func_2964
	$E6BA  A0 00:       ldy #$00
	$E6BC  98:          tya 
-	$E6BD  8D 07 20:    sta PPUDATA
	$E6C0  C8:          iny 
	$E6C1  C0 40:       cpy #$40
	$E6C3  90 F8:       bcc -		; $E6BD
	$E6C5  20 1B C9:    jsr _queryKeyInput
	$E6C8  A9 3F:       lda #$3F
	$E6CA  A0 00:       ldy #$00
	$E6CC  20 64 E9:    jsr _func_2964
-	$E6CF  B9 16 E9:    lda _data_2916_indexed,y
	$E6D2  8D 07 20:    sta PPUDATA
	$E6D5  C8:          iny 
	$E6D6  C0 20:       cpy #$20
	$E6D8  90 F5:       bcc -		; $E6CF
	$E6DA  A9 3F:       lda #$3F
	$E6DC  A0 00:       ldy #$00
	$E6DE  20 64 E9:    jsr _func_2964
	$E6E1  98:          tya 
	$E6E2  20 64 E9:    jsr _func_2964
	$E6E5  A9 23:       lda #$23
	$E6E7  A0 49:       ldy #$49
	$E6E9  20 64 E9:    jsr _func_2964
	$E6EC  A0 0D:       ldy #$0D
-	$E6EE  B9 36 E9:    lda _data_2936_indexed,y
	$E6F1  8D 07 20:    sta PPUDATA
	$E6F4  88:          dey 
	$E6F5  10 F7:       bpl -		; $E6EE
	$E6F7  A9 22:       lda #$22
	$E6F9  A0 EB:       ldy #$EB
	$E6FB  20 64 E9:    jsr _func_2964
	$E6FE  A0 03:       ldy #$03
-	$E700  B9 50 E9:    lda _data_2950_indexed,y
	$E703  8D 07 20:    sta PPUDATA
	$E706  88:          dey 
	$E707  10 F7:       bpl -		; $E700
	$E709  20 24 E8:    jsr _func_2824
	$E70C  A5 33:       lda $33
	$E70E  0A:          asl a
	$E70F  0A:          asl a
	$E710  0A:          asl a
	$E711  0A:          asl a
	$E712  18:          clc 
	$E713  69 7F:       adc #$7F
	$E715  8D 00 02:    sta $0200
	$E718  A9 FF:       lda #$FF
	$E71A  8D 01 02:    sta $0201
	$E71D  A9 00:       lda #$00
	$E71F  8D 02 02:    sta $0202
	$E722  A9 40:       lda #$40
	$E724  8D 03 02:    sta $0203
	$E727  20 1B C9:    jsr _queryKeyInput
	$E72A  A9 20:       lda #$20
	$E72C  A0 00:       ldy #$00
	$E72E  20 64 E9:    jsr _func_2964
	$E731  8C 05 20:    sty PPUSCROLL
	$E734  8C 05 20:    sty PPUSCROLL
	$E737  A9 91:       lda #$91
	$E739  8D 00 20:    sta PPUCTRL
	$E73C  A9 1E:       lda #$1E
	$E73E  8D 01 20:    sta PPUMASK
	$E741  A0 00:       ldy #$00
	$E743  84 17:       sty $17
	$E745  88:          dey 
	$E746  84 18:       sty $18
--	$E748  20 1B C9:    jsr _queryKeyInput
	$E74B  A5 17:       lda $17
	$E74D  8D 05 20:    sta PPUSCROLL
	$E750  A9 00:       lda #$00
	$E752  8D 05 20:    sta PPUSCROLL
	$E755  A8:          tay 
	$E756  A9 91:       lda #$91
	$E758  8D 00 20:    sta PPUCTRL
	$E75B  A2 06:       ldx #$06
-	$E75D  20 08 FF:    jsr _func_3F08
	$E760  CA:          dex 
	$E761  10 FA:       bpl -		; $E75D
	$E763  A5 18:       lda $18
	$E765  8D 05 20:    sta PPUSCROLL
	$E768  8D 05 20:    sta PPUSCROLL
	$E76B  A5 14:       lda ppuctrl_state
	$E76D  8D 00 20:    sta PPUCTRL
	$E770  A2 04:       ldx #$04
-	$E772  20 08 FF:    jsr _func_3F08
	$E775  CA:          dex 
	$E776  10 FA:       bpl -		; $E772
	$E778  A9 00:       lda #$00
	$E77A  8D 05 20:    sta PPUSCROLL
	$E77D  8D 05 20:    sta PPUSCROLL
	$E780  A5 17:       lda $17
	$E782  18:          clc 
	$E783  69 04:       adc #$04
	$E785  85 17:       sta $17
	$E787  A5 18:       lda $18
	$E789  38:          sec 
	$E78A  E9 04:       sbc #$04
	$E78C  85 18:       sta $18
	$E78E  A5 17:       lda $17
	$E790  C9 FC:       cmp #$FC
	$E792  F0 03:       beq +		; $E797
	$E794  4C 48 E7:    jmp --		; $E748

+	$E797  20 1B C9:    jsr _queryKeyInput
	$E79A  A5 14:       lda ppuctrl_state
	$E79C  8D 00 20:    sta PPUCTRL
	$E79F  A9 00:       lda #$00
	$E7A1  8D 05 20:    sta PPUSCROLL
	$E7A4  8D 05 20:    sta PPUSCROLL
	$E7A7  C6 37:       dec $37
	$E7A9  10 09:       bpl +		; $E7B4
	$E7AB  A9 03:       lda #$03
	$E7AD  20 8E F4:    jsr _setLevelSoundData
	$E7B0  A9 02:       lda #$02
	$E7B2  85 37:       sta $37
+ --	$E7B4  A9 58:       lda #$58
	$E7B6  85 18:       sta $18
	$E7B8  A9 02:       lda #$02
	$E7BA  85 19:       sta $19
	$E7BC  85 17:       sta $17
-	$E7BE  20 6B E9:    jsr _func_296B
	$E7C1  20 81 E9:    jsr _func_2981
	$E7C4  20 81 E9:    jsr _func_2981
	$E7C7  20 1B C9:    jsr _queryKeyInput
	$E7CA  20 24 E8:    jsr _func_2824
	$E7CD  20 06 C9:    jsr _func_0906
	$E7D0  20 05 F5:    jsr _LevelSoundPlay
	$E7D3  A5 33:       lda $33
	$E7D5  0A:          asl a
	$E7D6  0A:          asl a
	$E7D7  0A:          asl a
	$E7D8  0A:          asl a
	$E7D9  18:          clc 
	$E7DA  69 7F:       adc #$7F
	$E7DC  8D 00 02:    sta $0200
	$E7DF  A5 17:       lda $17
	$E7E1  D0 14:       bne ++		; $E7F7
	$E7E3  A5 6B:       lda $6B
	$E7E5  F0 10:       beq ++		; $E7F7
	$E7E7  A5 33:       lda $33
	$E7E9  18:          clc 
	$E7EA  69 01:       adc #$01
	$E7EC  C9 03:       cmp #$03
	$E7EE  90 02:       bcc +		; $E7F2
	$E7F0  A9 00:       lda #$00
+	$E7F2  85 33:       sta $33
	$E7F4  4C B4 E7:    jmp --		; $E7B4

++	$E7F7  A5 6B:       lda $6B
	$E7F9  85 17:       sta $17
	$E7FB  C6 18:       dec $18
	$E7FD  A5 18:       lda $18
	$E7FF  C9 FF:       cmp #$FF
	$E801  D0 BB:       bne -		; $E7BE
	$E803  C6 19:       dec $19
	$E805  10 B7:       bpl -		; $E7BE
	$E807  A5 B8:       lda $B8
	$E809  10 B3:       bpl -		; $E7BE
	$E80B  A9 00:       lda #$00
	$E80D  85 2A:       sta $2A
	$E80F  4C D5 C0:    jmp _loc_00D5
;------------------------------------------
_func_2812
	$E812  20 64 E9:    jsr _func_2964
	$E815  A0 0B:       ldy #$0B
-	$E817  B9 44 E9:    lda _data_2944_indexed,y
	$E81A  8D 07 20:    sta PPUDATA
	$E81D  88:          dey 
	$E81E  10 F7:       bpl -		; $E817
	$E820  8E 07 20:    stx PPUDATA
	$E823  60:          rts 
;------------------------------------------
_func_2824
	$E824  A9 00:       lda #$00
	$E826  85 38:       sta $38
	$E828  A9 22:       lda #$22
	$E82A  A0 EF:       ldy #$EF
	$E82C  20 64 E9:    jsr _func_2964
	$E82F  A4 33:       ldy $33
	$E831  B9 69 CF:    lda _data_0F69_indexed,y
	$E834  18:          clc 
	$E835  69 04:       adc #$04
	$E837  AA:          tax 
	$E838  A0 04:       ldy #$04
-	$E83A  86 1A:       stx $1A
	$E83C  B5 00:       lda $00,x
	$E83E  D0 08:       bne +		; $E848
	$E840  A6 38:       ldx $38
	$E842  D0 06:       bne ++		; $E84A
	$E844  A9 2D:       lda #$2D
	$E846  D0 02:       bne ++		; $E84A

+	$E848  85 38:       sta $38
++	$E84A  8D 07 20:    sta PPUDATA
	$E84D  A6 1A:       ldx $1A
	$E84F  CA:          dex 
	$E850  88:          dey 
	$E851  10 E7:       bpl -		; $E83A
	$E853  A9 00:       lda #$00
	$E855  8D 07 20:    sta PPUDATA
	$E858  A9 3F:       lda #$3F
	$E85A  A0 08:       ldy #$08
	$E85C  20 64 E9:    jsr _func_2964
	$E85F  A9 0F:       lda #$0F
	$E861  20 01 D1:    jsr _func_1101
	$E864  A4 33:       ldy $33
	$E866  B9 54 E9:    lda _data_2954_indexed,y
	$E869  20 01 D1:    jsr _func_1101
	$E86C  60:          rts 
;------------------------------------------
_data_286D_indexed
	$E86D               .byte $0A,$13,$FE,$02,$A9,$11,$09,$2F,$2D,$2F,$2D,$2F,$2D,$2F,$2D,$2F
	$E87D               .byte $01,$11,$05,$12,$01,$2F,$2D,$2F,$2D,$2F,$2D,$2F,$2D,$2D,$2F,$2D
	$E88D               .byte $2F,$2D,$2F,$2D,$2F,$02,$12,$FE,$2D,$11,$01,$11,$02,$2F,$2D,$2F
	$E89D               .byte $2D,$2F,$2D,$2F,$2F,$2D,$2F,$2D,$2F,$2D,$2F,$03,$11,$06,$11,$03
	$E8AD               .byte $2F,$2D,$2F,$2D,$2F,$2D,$2D,$2F,$2D,$2F,$2D,$2F,$04,$11,$06,$11
	$E8BD               .byte $04,$2F,$2D,$2F,$2D,$2F,$0F,$0F,$0F,$0F,$04,$13,$FB,$2D,$FA,$12
	$E8CD               .byte $FB,$2D,$FA,$12,$FB,$2D,$13,$FE,$08,$11,$2D,$11,$2D,$11,$2D,$11
	$E8DD               .byte $2D,$11,$2D,$11,$2D,$11,$0B,$13,$FD,$2D,$11,$2D,$11,$2D,$11,$03
	$E8ED               .byte $12,$FE,$09,$11,$FF,$2E,$BA,$2D,$14,$2D,$11,$2D,$11,$2D,$11,$0B
	$E8FD               .byte $11,$2D,$FF,$2E,$2D,$11,$2D,$11,$2D,$FC,$12,$FD,$2D,$13,$FE,$03
	$E90D               .byte $00
_data_290E_indexed
	$E90E               .byte $00,$00,$00,$00,$55,$A5,$FF,$00
_data_2916_indexed
	$E916               .byte $0F,$0F,$16,$30,$0F,$0F,$27,$27,$0F,$0F,$21,$21,$0F,$0F,$30,$30
	$E926               .byte $0F,$3A,$00,$00,$0F,$00,$00,$00,$0F,$00,$00,$00,$0F,$00,$00,$00
_data_2936_indexed
	$E936               .byte $18,$0D,$17,$0E,$1D,$17,$12,$17,$2D,$04,$08,$09,$01,$24
_data_2944_indexed
	$E944               .byte $2D,$15,$0E,$1F,$0E,$15,$2D,$15,$15,$12,$14,$1C
_data_2950_indexed
	$E950               .byte $26,$19,$18,$1D
_data_2954_indexed
	$E954               .byte $21,$25,$2A
_func_2957
	$E957  A9 00:       lda #$00
	$E959  85 6D:       sta $6D
	$E95B  85 6E:       sta $6E
	$E95D  A9 FF:       lda #$FF
	$E95F  85 6F:       sta $6F
	$E961  85 70:       sta $70
	$E963  60:          rts 
;------------------------------------------
_func_2964
	$E964  8D 06 20:    sta PPUADDR
	$E967  8C 06 20:    sty PPUADDR
	$E96A  60:          rts 
;------------------------------------------
_func_296B
	$E96B  06 2E:       asl $2E
	$E96D  26 2F:       rol $2F
	$E96F  2A:          rol a
	$E970  2A:          rol a
	$E971  45 2E:       eor $2E
	$E973  2A:          rol a
	$E974  45 2E:       eor $2E
	$E976  4A:          lsr a
	$E977  4A:          lsr a
	$E978  49 FF:       eor #$FF
	$E97A  29 01:       and #$01
	$E97C  05 2E:       ora $2E
	$E97E  85 2E:       sta $2E
	$E980  60:          rts 
;------------------------------------------
_func_2981
	$E981  06 30:       asl $30
	$E983  26 31:       rol $31
	$E985  2A:          rol a
	$E986  2A:          rol a
	$E987  45 30:       eor $30
	$E989  2A:          rol a
	$E98A  45 30:       eor $30
	$E98C  4A:          lsr a
	$E98D  4A:          lsr a
	$E98E  49 FF:       eor #$FF
	$E990  29 01:       and #$01
	$E992  05 30:       ora $30
	$E994  85 30:       sta $30
	$E996  60:          rts 
;------------------------------------------
_func_2997
	$E997  A0 07:       ldy #$07
_func_2999
	$E999  A9 00:       lda #$00
	$E99B  85 A0:       sta $A0
	$E99D  85 A2:       sta $A2
	$E99F  85 A3:       sta $A3
-	$E9A1  46 A1:       lsr $A1
	$E9A3  90 0D:       bcc +		; $E9B2
	$E9A5  A5 A2:       lda $A2
	$E9A7  18:          clc 
	$E9A8  65 9F:       adc $9F
	$E9AA  85 A2:       sta $A2
	$E9AC  A5 A3:       lda $A3
	$E9AE  65 A0:       adc $A0
	$E9B0  85 A3:       sta $A3
+	$E9B2  06 9F:       asl $9F
	$E9B4  26 A0:       rol $A0
	$E9B6  88:          dey 
	$E9B7  10 E8:       bpl -		; $E9A1
	$E9B9  60:          rts 
;------------------------------------------
_func_29BA
	$E9BA  E6 34:       inc $34
	$E9BC  A5 71:       lda 游戏演示标志
	$E9BE  D0 03:       bne +		; $E9C3
	$E9C0  20 D2 CF:    jsr _func_0FD2
+	$E9C3  20 43 C5:    jsr _func_0543
	$E9C6  A9 00:       lda #$00
	$E9C8  85 4F:       sta 程序及卡通定义页选择控制器
	$E9CA  20 38 CA:    jsr _func_0A38
	$E9CD  20 57 E9:    jsr _func_2957
	$E9D0  20 75 CC:    jsr _func_0C75
	$E9D3  20 14 FF:    jsr _func_3F14
	$E9D6  20 1B C9:    jsr _queryKeyInput
	$E9D9  20 1B D1:    jsr _func_111B
	$E9DC  20 14 FF:    jsr _func_3F14
	$E9DF  20 1B C9:    jsr _queryKeyInput
	$E9E2  20 57 E9:    jsr _func_2957
	$E9E5  20 75 CC:    jsr _func_0C75
	$E9E8  20 14 FF:    jsr _func_3F14
	$E9EB  20 1B C9:    jsr _queryKeyInput
	$E9EE  20 1B D1:    jsr _func_111B
	$E9F1  20 14 FF:    jsr _func_3F14
	$E9F4  20 1B C9:    jsr _queryKeyInput
	$E9F7  20 57 E9:    jsr _func_2957
	$E9FA  20 75 CC:    jsr _func_0C75
	$E9FD  20 14 FF:    jsr _func_3F14
	$EA00  20 1B C9:    jsr _queryKeyInput
	$EA03  E6 4F:       inc 程序及卡通定义页选择控制器
	$EA05  20 38 CA:    jsr _func_0A38
	$EA08  20 1B D1:    jsr _func_111B
	$EA0B  20 14 FF:    jsr _func_3F14
	$EA0E  C6 4F:       dec 程序及卡通定义页选择控制器
	$EA10  A9 F8:       lda #$F8
	$EA12  85 8F:       sta $8F
	$EA14  85 90:       sta $90
	$EA16  85 91:       sta $91
	$EA18  A0 00:       ldy #$00
	$EA1A  84 61:       sty $61
	$EA1C  84 62:       sty $62
	$EA1E  84 63:       sty $63
	$EA20  C8:          iny 
	$EA21  84 53:       sty $53
	$EA23  20 1B C9:    jsr _queryKeyInput
	$EA26  A9 21:       lda #$21
	$EA28  A0 2D:       ldy #$2D
	$EA2A  20 64 E9:    jsr _func_2964
	$EA2D  98:          tya 
	$EA2E  20 F5 D0:    jsr _func_10F5
	$EA31  A9 21:       lda #$21
	$EA33  85 22:       sta $22
	$EA35  A9 0E:       lda #$0E
	$EA37  85 23:       sta $23
	$EA39  A0 03:       ldy #$03
--	$EA3B  A5 22:       lda $22
	$EA3D  8D 06 20:    sta PPUADDR
	$EA40  A5 23:       lda $23
	$EA42  8D 06 20:    sta PPUADDR
	$EA45  A2 03:       ldx #$03
-	$EA47  BD 58 EB:    lda _data_2B58_indexed,x
	$EA4A  8D 07 20:    sta PPUDATA
	$EA4D  CA:          dex 
	$EA4E  10 F7:       bpl -		; $EA47
	$EA50  A5 23:       lda $23
	$EA52  18:          clc 
	$EA53  69 20:       adc #$20
	$EA55  85 23:       sta $23
	$EA57  88:          dey 
	$EA58  10 E1:       bpl --		; $EA3B
	$EA5A  A9 21:       lda #$21
	$EA5C  A0 4C:       ldy #$4C
	$EA5E  20 64 E9:    jsr _func_2964
	$EA61  A9 2D:       lda #$2D
	$EA63  8D 07 20:    sta PPUDATA
	$EA66  A9 23:       lda #$23
	$EA68  A0 D3:       ldy #$D3
	$EA6A  20 64 E9:    jsr _func_2964
	$EA6D  A9 FF:       lda #$FF
	$EA6F  20 01 D1:    jsr _func_1101
	$EA72  20 06 C9:    jsr _func_0906
	$EA75  A9 FD:       lda #$FD
	$EA77  A0 00:       ldy #$00
	$EA79  20 88 F0:    jsr _func_3088
	$EA7C  C8:          iny 
	$EA7D  20 88 F0:    jsr _func_3088
	$EA80  A9 20:       lda #$20
	$EA82  C8:          iny 
	$EA83  20 88 F0:    jsr _func_3088
	$EA86  A9 70:       lda #$70
	$EA88  8D A3 03:    sta $03A3
	$EA8B  A9 78:       lda #$78
	$EA8D  8D A7 03:    sta $03A7
	$EA90  A9 80:       lda #$80
	$EA92  8D AB 03:    sta $03AB
	$EA95  A9 88:       lda #$88
	$EA97  8D AF 03:    sta $03AF
	$EA9A  20 6E F4:    jsr _soundPrepare
	$EA9D  A9 00:       lda #$00
	$EA9F  20 8E F4:    jsr _setLevelSoundData
	$EAA2  A0 00:       ldy #$00
	$EAA4  20 08 FF:    jsr _func_3F08
	$EAA7  20 14 FF:    jsr _func_3F14
	$EAAA  A9 01:       lda #$01
	$EAAC  85 4F:       sta 程序及卡通定义页选择控制器
	$EAAE  A9 1E:       lda #$1E
	$EAB0  20 5C EB:    jsr _func_2B5C
	$EAB3  A9 58:       lda #$58
	$EAB5  A0 00:       ldy #$00
	$EAB7  20 88 F0:    jsr _func_3088
	$EABA  A9 06:       lda #$06
	$EABC  20 8E F4:    jsr _setLevelSoundData
	$EABF  A9 3C:       lda #$3C
	$EAC1  20 5C EB:    jsr _func_2B5C
	$EAC4  A9 50:       lda #$50
	$EAC6  A0 00:       ldy #$00
	$EAC8  20 88 F0:    jsr _func_3088
	$EACB  A9 22:       lda #$22
	$EACD  A0 02:       ldy #$02
	$EACF  20 88 F0:    jsr _func_3088
	$EAD2  A9 3C:       lda #$3C
	$EAD4  20 5C EB:    jsr _func_2B5C
	$EAD7  A9 48:       lda #$48
	$EAD9  A0 00:       ldy #$00
	$EADB  20 88 F0:    jsr _func_3088
	$EADE  A9 3C:       lda #$3C
	$EAE0  20 5C EB:    jsr _func_2B5C
	$EAE3  A9 40:       lda #$40
	$EAE5  A0 00:       ldy #$00
	$EAE7  20 88 F0:    jsr _func_3088
	$EAEA  A9 21:       lda #$21
	$EAEC  A0 02:       ldy #$02
	$EAEE  20 88 F0:    jsr _func_3088
	$EAF1  A9 0A:       lda #$0A
	$EAF3  20 5C EB:    jsr _func_2B5C
	$EAF6  A5 53:       lda $53
	$EAF8  85 7A:       sta $7A
	$EAFA  20 1B C9:    jsr _queryKeyInput
	$EAFD  A5 14:       lda ppuctrl_state
	$EAFF  8D 00 20:    sta PPUCTRL
	$EB02  A9 21:       lda #$21
	$EB04  85 22:       sta $22
	$EB06  A9 0E:       lda #$0E
	$EB08  85 23:       sta $23
	$EB0A  A0 03:       ldy #$03
--	$EB0C  A5 22:       lda $22
	$EB0E  8D 06 20:    sta PPUADDR
	$EB11  A5 23:       lda $23
	$EB13  8D 06 20:    sta PPUADDR
	$EB16  A2 03:       ldx #$03
	$EB18  A9 2D:       lda #$2D
-	$EB1A  8D 07 20:    sta PPUDATA
	$EB1D  CA:          dex 
	$EB1E  10 FA:       bpl -		; $EB1A
	$EB20  A5 23:       lda $23
	$EB22  18:          clc 
	$EB23  69 20:       adc #$20
	$EB25  85 23:       sta $23
	$EB27  88:          dey 
	$EB28  10 E2:       bpl --		; $EB0C
	$EB2A  A9 21:       lda #$21
	$EB2C  A0 4C:       ldy #$4C
	$EB2E  20 64 E9:    jsr _func_2964
	$EB31  A9 5F:       lda #$5F
	$EB33  8D 07 20:    sta PPUDATA
	$EB36  A0 06:       ldy #$06
-	$EB38  A9 2D:       lda #$2D
	$EB3A  8D 07 20:    sta PPUDATA
	$EB3D  88:          dey 
	$EB3E  10 F8:       bpl -		; $EB38
	$EB40  A9 23:       lda #$23
	$EB42  A0 D3:       ldy #$D3
	$EB44  20 64 E9:    jsr _func_2964
	$EB47  A9 55:       lda #$55
	$EB49  20 01 D1:    jsr _func_1101
	$EB4C  20 06 C9:    jsr _func_0906
	$EB4F  A0 00:       ldy #$00
	$EB51  20 08 FF:    jsr _func_3F08
	$EB54  20 14 FF:    jsr _func_3F14
	$EB57  60:          rts 
;------------------------------------------
_data_2B58_indexed
	$EB58               .byte $9E,$9D,$9D,$9C
_func_2B5C
	$EB5C  85 A4:       sta $A4
-	$EB5E  20 1B C9:    jsr _queryKeyInput
	$EB61  20 38 CA:    jsr _func_0A38
	$EB64  20 06 C9:    jsr _func_0906
	$EB67  A9 00:       lda #$00
	$EB69  20 8E F4:    jsr _setLevelSoundData
	$EB6C  A5 6D:       lda $6D
	$EB6E  D0 0B:       bne +		; $EB7B
	$EB70  A5 53:       lda $53
	$EB72  38:          sec 
	$EB73  E9 02:       sbc #$02
	$EB75  10 11:       bpl ++		; $EB88
	$EB77  A9 00:       lda #$00
	$EB79  F0 0D:       beq ++		; $EB88

+	$EB7B  A5 53:       lda $53
	$EB7D  18:          clc 
	$EB7E  69 03:       adc #$03
	$EB80  85 53:       sta $53
	$EB82  C9 78:       cmp #$78
	$EB84  90 02:       bcc ++		; $EB88
	$EB86  A9 78:       lda #$78
++	$EB88  85 53:       sta $53
	$EB8A  A5 6F:       lda $6F
	$EB8C  30 04:       bmi +		; $EB92
	$EB8E  49 01:       eor #$01
	$EB90  85 47:       sta $47
+	$EB92  A0 00:       ldy #$00
	$EB94  20 08 FF:    jsr _func_3F08
	$EB97  20 14 FF:    jsr _func_3F14
	$EB9A  C6 A4:       dec $A4
	$EB9C  D0 C0:       bne -		; $EB5E
	$EB9E  60:          rts 
;------------------------------------------
_func_2B9F
	$EB9F  A4 2D:       ldy $2D
	$EBA1  A5 71:       lda 游戏演示标志
	$EBA3  D0 0E:       bne +		; $EBB3
	$EBA5  A9 00:       lda #$00
	$EBA7  85 76:       sta $76
	$EBA9  B9 60 F0:    lda _DataPointerTableLo_3060,y
	$EBAC  85 77:       sta $77
	$EBAE  B9 6A F0:    lda _DataPointerTableHi_3060,y
	$EBB1  85 78:       sta $78
+	$EBB3  B9 66 EE:    lda _DataPointerTableLo_2E66,y
	$EBB6  85 22:       sta $22
	$EBB8  B9 70 EE:    lda _DataPointerTableHi_2E66,y
	$EBBB  85 23:       sta $23
	$EBBD  A9 00:       lda #$00
	$EBBF  85 24:       sta $24
	$EBC1  A9 07:       lda #$07
	$EBC3  85 25:       sta $25
	$EBC5  A0 00:       ldy #$00
	$EBC7  84 17:       sty $17
	$EBC9  84 18:       sty $18
	$EBCB  84 1B:       sty $1B
---	$EBCD  A0 01:       ldy #$01
	$EBCF  B1 22:       lda ($22),y
	$EBD1  38:          sec 
	$EBD2  E5 17:       sbc $17
	$EBD4  85 19:       sta $19
	$EBD6  C8:          iny 
	$EBD7  B1 22:       lda ($22),y
	$EBD9  E5 18:       sbc $18
	$EBDB  85 1A:       sta $1A
	$EBDD  D0 3D:       bne ++		; $EC1C
	$EBDF  A5 19:       lda $19
	$EBE1  C9 20:       cmp #$20
	$EBE3  B0 37:       bcs ++		; $EC1C
--	$EBE5  88:          dey 
	$EBE6  91 24:       sta ($24),y
	$EBE8  88:          dey 
	$EBE9  B1 22:       lda ($22),y
	$EBEB  91 24:       sta ($24),y
	$EBED  D0 0A:       bne +		; $EBF9
	$EBEF  A0 02:       ldy #$02
	$EBF1  91 24:       sta ($24),y
	$EBF3  C8:          iny 
	$EBF4  91 24:       sta ($24),y
	$EBF6  4C 4C EC:    jmp +++		; $EC4C

+	$EBF9  A9 00:       lda #$00
	$EBFB  85 17:       sta $17
	$EBFD  85 18:       sta $18
	$EBFF  A9 30:       lda #$30
	$EC01  85 1C:       sta $1C
	$EC03  A5 22:       lda $22
	$EC05  18:          clc 
	$EC06  69 03:       adc #$03
	$EC08  85 22:       sta $22
	$EC0A  90 02:       bcc +		; $EC0E
	$EC0C  E6 23:       inc $23
+ -	$EC0E  A5 24:       lda $24
	$EC10  18:          clc 
	$EC11  69 02:       adc #$02
	$EC13  85 24:       sta $24
	$EC15  90 02:       bcc +		; $EC19 -> $EBCD
	$EC17  E6 25:       inc $25
+	$EC19  4C CD EB:    jmp ---		; $EBCD

++	$EC1C  A5 1A:       lda $1A
	$EC1E  D0 08:       bne +		; $EC28
	$EC20  A5 19:       lda $19
	$EC22  C9 51:       cmp #$51
	$EC24  B0 02:       bcs +		; $EC28
	$EC26  90 BD:       bcc --		; $EBE5
+	$EC28  88:          dey 
	$EC29  A5 1C:       lda $1C
	$EC2B  91 24:       sta ($24),y
	$EC2D  88:          dey 
	$EC2E  A5 1B:       lda $1B
	$EC30  29 01:       and #$01
	$EC32  D0 02:       bne +		; $EC36
	$EC34  A9 81:       lda #$81
+	$EC36  91 24:       sta ($24),y
	$EC38  E6 1B:       inc $1B
	$EC3A  A5 17:       lda $17
	$EC3C  18:          clc 
	$EC3D  65 1C:       adc $1C
	$EC3F  85 17:       sta $17
	$EC41  90 02:       bcc +		; $EC45
	$EC43  E6 18:       inc $18
+	$EC45  A9 20:       lda #$20
	$EC47  85 1C:       sta $1C
	$EC49  4C 0E EC:    jmp -		; $EC0E

+++	$EC4C  A4 2D:       ldy $2D
	$EC4E  B9 C8 EC:    lda _DataPointerTableLo_2CC8,y
	$EC51  85 22:       sta $22
	$EC53  B9 D2 EC:    lda _DataPointerTableHi_2CC8,y
	$EC56  85 23:       sta $23
	$EC58  A9 60:       lda #$60
	$EC5A  85 24:       sta $24
	$EC5C  A9 06:       lda #$06
	$EC5E  85 25:       sta $25
---	$EC60  A0 00:       ldy #$00
	$EC62  B1 22:       lda ($22),y
	$EC64  91 24:       sta ($24),y
	$EC66  85 17:       sta $17
	$EC68  C8:          iny 
	$EC69  B1 22:       lda ($22),y
	$EC6B  91 24:       sta ($24),y
	$EC6D  A5 17:       lda $17
	$EC6F  D0 16:       bne ++		; $EC87
	$EC71  B1 22:       lda ($22),y
	$EC73  D0 01:       bne +		; $EC76
	$EC75  60:          rts 

+ --	$EC76  A5 22:       lda $22
	$EC78  18:          clc 
	$EC79  69 02:       adc #$02
	$EC7B  85 22:       sta $22
	$EC7D  90 02:       bcc +		; $EC81
	$EC7F  E6 23:       inc $23
+	$EC81  20 BC EC:    jsr _func_2CBC
	$EC84  4C 60 EC:    jmp ---		; $EC60

++	$EC87  C9 80:       cmp #$80
	$EC89  F0 EB:       beq --		; $EC76
	$EC8B  C8:          iny 
	$EC8C  B1 22:       lda ($22),y
	$EC8E  F0 04:       beq +		; $EC94
	$EC90  C9 80:       cmp #$80
	$EC92  D0 E2:       bne --		; $EC76
+ -	$EC94  A5 17:       lda $17
	$EC96  30 0B:       bmi +		; $ECA3
	$EC98  38:          sec 
	$EC99  E9 08:       sbc #$08
	$EC9B  85 17:       sta $17
	$EC9D  30 D7:       bmi --		; $EC76
	$EC9F  F0 D5:       beq --		; $EC76
	$ECA1  10 09:       bpl ++		; $ECAC
+	$ECA3  18:          clc 
	$ECA4  69 08:       adc #$08
	$ECA6  85 17:       sta $17
	$ECA8  10 CC:       bpl --		; $EC76
	$ECAA  F0 CA:       beq --		; $EC76
++	$ECAC  20 BC EC:    jsr _func_2CBC
	$ECAF  A0 00:       ldy #$00
	$ECB1  A5 17:       lda $17
	$ECB3  91 24:       sta ($24),y
	$ECB5  C8:          iny 
	$ECB6  A9 01:       lda #$01
	$ECB8  91 24:       sta ($24),y
	$ECBA  D0 D8:       bne -		; $EC94
;------------------------------------------
_func_2CBC
	$ECBC  A5 24:       lda $24
	$ECBE  18:          clc 
	$ECBF  69 02:       adc #$02
	$ECC1  85 24:       sta $24
	$ECC3  90 02:       bcc +		; $ECC7 -> rts
	$ECC5  E6 25:       inc $25
+	$ECC7  60:          rts 
;------------------------------------------
_DataPointerTableLo_2CC8
	$ECC8  DC:          .byte < (DataTableEntry_2CDC)
	$ECC9  EA:          .byte < (DataTableEntry_2CEA)
	$ECCA  04:          .byte < (DataTableEntry_2D04)
	$ECCB  26:          .byte < (DataTableEntry_2D26)
	$ECCC  4E:          .byte < (DataTableEntry_2D4E)
	$ECCD  74:          .byte < (DataTableEntry_2D74)
	$ECCE  9A:          .byte < (DataTableEntry_2D9A)
	$ECCF  CC:          .byte < (DataTableEntry_2DCC)
	$ECD0  FE:          .byte < (DataTableEntry_2DFE)
	$ECD1  30:          .byte < (DataTableEntry_2E30)
_DataPointerTableHi_2CC8
	$ECD2  EC:          .byte > (DataTableEntry_2CDC)
	$ECD3  EC:          .byte > (DataTableEntry_2CEA)
	$ECD4  ED:          .byte > (DataTableEntry_2D04)
	$ECD5  ED:          .byte > (DataTableEntry_2D26)
	$ECD6  ED:          .byte > (DataTableEntry_2D4E)
	$ECD7  ED:          .byte > (DataTableEntry_2D74)
	$ECD8  ED:          .byte > (DataTableEntry_2D9A)
	$ECD9  ED:          .byte > (DataTableEntry_2DCC)
	$ECDA  ED:          .byte > (DataTableEntry_2DFE)
	$ECDB  EE:          .byte > (DataTableEntry_2E30)
DataTableEntry_2CDC
	$ECDC               .byte $00,$36,$0E,$47,$00,$4C,$0E,$47,$80,$00,$00,$16,$00,$00
DataTableEntry_2CEA
	$ECEA               .byte $00,$12,$12,$0C,$00,$30,$F2,$58,$00,$10,$EE,$0C,$00,$34,$10,$2A
	$ECFA               .byte $00,$12,$28,$08,$80,$00,$00,$0E,$00,$00
DataTableEntry_2D04
	$ED04               .byte $00,$46,$27,$09,$14,$11,$00,$17,$12,$0B,$00,$20,$2C,$12,$00,$0C
	$ED14               .byte $D5,$12,$00,$08,$F0,$10,$00,$14,$16,$14,$0F,$32,$80,$00,$00,$19
	$ED24               .byte $00,$00
DataTableEntry_2D26
	$ED26               .byte $00,$16,$F0,$0E,$00,$1A,$10,$0E,$00,$10,$2C,$06,$00,$0C,$11,$24
	$ED36               .byte $18,$0A,$00,$01,$F3,$0D,$00,$14,$F0,$0D,$00,$10,$F0,$1B,$00,$14
	$ED46               .byte $2E,$1B,$80,$00,$00,$10,$00,$00
DataTableEntry_2D4E
	$ED4E               .byte $00,$38,$0E,$50,$00,$01,$DC,$02,$00,$01,$20,$0F,$00,$08,$D0,$06
	$ED5E               .byte $D8,$06,$00,$04,$28,$06,$16,$08,$00,$01,$F4,$06,$00,$10,$2E,$0D
	$ED6E               .byte $80,$00,$00,$24,$00,$00
DataTableEntry_2D74
	$ED74               .byte $00,$18,$30,$08,$10,$20,$16,$12,$00,$01,$DD,$19,$00,$08,$29,$14
	$ED84               .byte $00,$04,$ED,$05,$00,$18,$E0,$0C,$00,$1A,$E0,$1B,$00,$3A,$14,$09
	$ED94               .byte $80,$00,$00,$10,$00,$00
DataTableEntry_2D9A
	$ED9A               .byte $00,$12,$12,$0C,$00,$1A,$EE,$0C,$00,$0E,$D1,$0F,$00,$0E,$2F,$0F
	$EDAA               .byte $00,$19,$2C,$06,$00,$1A,$2C,$06,$00,$2C,$17,$0A,$00,$01,$DC,$09
	$EDBA               .byte $00,$08,$24,$0C,$00,$01,$F7,$0D,$00,$0A,$26,$0F,$80,$00,$00,$0A
	$EDCA               .byte $00,$00
DataTableEntry_2DCC
	$EDCC               .byte $00,$18,$28,$13,$00,$01,$F2,$0E,$00,$08,$27,$0F,$00,$01,$D2,$05
	$EDDC               .byte $00,$19,$F0,$08,$00,$01,$26,$0B,$00,$04,$D2,$0E,$00,$0B,$EC,$20
	$EDEC               .byte $00,$0C,$30,$04,$00,$01,$D6,$0F,$00,$16,$2C,$06,$80,$00,$00,$14
	$EDFC               .byte $00,$00
DataTableEntry_2DFE
	$EDFE               .byte $00,$10,$0E,$1C,$00,$06,$E0,$14,$D0,$04,$00,$01,$1A,$14,$26,$07
	$EE0E               .byte $00,$30,$2B,$16,$00,$01,$E0,$12,$00,$06,$0E,$13,$00,$1A,$1E,$14
	$EE1E               .byte $00,$01,$E0,$20,$00,$04,$2C,$0F,$00,$0A,$2C,$07,$80,$00,$00,$0C
	$EE2E               .byte $00,$00
DataTableEntry_2E30
	$EE30               .byte $00,$28,$2C,$0E,$00,$03,$D3,$02,$00,$0A,$30,$0F,$00,$0E,$D8,$19
	$EE40               .byte $00,$04,$1E,$21,$00,$02,$E0,$11,$00,$04,$10,$10,$00,$11,$30,$0C
	$EE50               .byte $00,$02,$E0,$0C,$00,$05,$26,$16,$00,$06,$D0,$0A,$00,$01,$2E,$03
	$EE60               .byte $80,$00,$00,$0D,$00,$00
_DataPointerTableLo_2E66
	$EE66  7A:          .byte < (DataTableEntry_2E7A)
	$EE67  95:          .byte < (DataTableEntry_2E95)
	$EE68  B9:          .byte < (DataTableEntry_2EB9)
	$EE69  E6:          .byte < (DataTableEntry_2EE6)
	$EE6A  0A:          .byte < (DataTableEntry_2F0A)
	$EE6B  37:          .byte < (DataTableEntry_2F37)
	$EE6C  76:          .byte < (DataTableEntry_2F76)
	$EE6D  A3:          .byte < (DataTableEntry_2FA3)
	$EE6E  F4:          .byte < (DataTableEntry_2FF4)
	$EE6F  33:          .byte < (DataTableEntry_3033)
_DataPointerTableHi_2E66
	$EE70  EE:          .byte > (DataTableEntry_2E7A)
	$EE71  EE:          .byte > (DataTableEntry_2E95)
	$EE72  EE:          .byte > (DataTableEntry_2EB9)
	$EE73  EE:          .byte > (DataTableEntry_2EE6)
	$EE74  EF:          .byte > (DataTableEntry_2F0A)
	$EE75  EF:          .byte > (DataTableEntry_2F37)
	$EE76  EF:          .byte > (DataTableEntry_2F76)
	$EE77  EF:          .byte > (DataTableEntry_2FA3)
	$EE78  EF:          .byte > (DataTableEntry_2FF4)
	$EE79  F0:          .byte > (DataTableEntry_3033)
DataTableEntry_2E7A
	$EE7A               .byte $02,$06,$00,$82,$01,$00,$83,$60,$01,$83,$20,$00,$83,$20,$00,$83
	$EE8A               .byte $80,$04,$83,$20,$00,$83,$20,$00,$00,$10,$03
DataTableEntry_2E95
	$EE95               .byte $02,$06,$00,$82,$01,$00,$0B,$60,$02,$0B,$20,$00,$0B,$20,$00,$83
	$EEA5               .byte $50,$05,$83,$20,$00,$83,$20,$00,$83,$B0,$01,$83,$20,$00,$83,$20
	$EEB5               .byte $00,$00,$12,$01
DataTableEntry_2EB9
	$EEB9               .byte $02,$06,$00,$82,$01,$00,$83,$D0,$01,$83,$20,$00,$83,$20,$00,$83
	$EEC9               .byte $10,$03,$83,$20,$00,$83,$20,$00,$03,$20,$01,$03,$20,$00,$03,$20
	$EED9               .byte $00,$83,$20,$02,$83,$30,$00,$83,$20,$00,$00,$28,$03
DataTableEntry_2EE6
	$EEE6               .byte $02,$06,$00,$82,$01,$00,$83,$D0,$02,$83,$20,$00,$83,$20,$00,$83
	$EEF6               .byte $C0,$01,$83,$20,$00,$83,$20,$00,$83,$30,$04,$83,$20,$00,$83,$20
	$EF06               .byte $00,$00,$C0,$01
DataTableEntry_2F0A
	$EF0A               .byte $02,$06,$00,$82,$01,$00,$83,$90,$04,$83,$20,$00,$83,$20,$00,$03
	$EF1A               .byte $B0,$00,$03,$20,$00,$03,$20,$00,$83,$A0,$00,$83,$20,$00,$83,$20
	$EF2A               .byte $00,$83,$30,$01,$83,$20,$00,$83,$20,$00,$00,$F8,$01
DataTableEntry_2F37
	$EF37               .byte $02,$06,$00,$82,$01,$00,$83,$60,$00,$83,$20,$00,$83,$20,$00,$83
	$EF47               .byte $20,$01,$83,$20,$00,$83,$20,$00,$03,$A0,$00,$03,$20,$00,$03,$20
	$EF57               .byte $00,$83,$00,$01,$83,$20,$00,$83,$20,$00,$03,$10,$02,$03,$20,$00
	$EF67               .byte $03,$20,$00,$03,$40,$01,$03,$20,$00,$03,$20,$00,$00,$C8,$03
DataTableEntry_2F76
	$EF76               .byte $02,$06,$00,$82,$01,$00,$03,$D0,$02,$03,$20,$00,$03,$20,$00,$83
	$EF86               .byte $10,$01,$83,$20,$00,$83,$20,$00,$83,$50,$01,$83,$20,$00,$83,$20
	$EF96               .byte $00,$83,$40,$01,$83,$20,$00,$83,$20,$00,$00,$C0,$05
DataTableEntry_2FA3
	$EFA3               .byte $02,$06,$00,$82,$01,$00,$83,$60,$00,$83,$20,$00,$83,$20,$00,$83
	$EFB3               .byte $80,$01,$83,$20,$00,$83,$20,$00,$03,$E0,$00,$03,$20,$00,$03,$20
	$EFC3               .byte $00,$B3,$40,$01,$B3,$20,$00,$B3,$20,$00,$03,$80,$00,$03,$20,$00
	$EFD3               .byte $03,$20,$00,$83,$70,$02,$83,$20,$00,$83,$20,$00,$03,$60,$00,$03
	$EFE3               .byte $20,$00,$03,$20,$00,$83,$40,$01,$83,$20,$00,$83,$20,$00,$00,$38
	$EFF3               .byte $01
DataTableEntry_2FF4
	$EFF4               .byte $02,$06,$00,$82,$01,$00,$03,$80,$01,$03,$20,$00,$03
DataTableEntry_3001
	$F001               .byte $20
DataTableEntry_3002
	$F002               .byte $00,$83,$A0,$01,$83,$20,$00,$83,$20,$00,$83,$90,$01,$83,$20,$00
	$F012               .byte $83,$20,$00,$03,$F0,$00,$03,$20,$00,$03,$20,$00,$83,$80,$04,$83
	$F022               .byte $20
_data_3023
	$F023               .byte $00,$83,$20,$00,$83,$E0,$00,$83,$20,$00,$83,$20,$00,$00,$18,$01
DataTableEntry_3033
	$F033               .byte $02,$06,$00,$82,$01,$00,$83,$E0,$00,$83,$20,$00,$83,$20,$00,$83
	$F043               .byte $60,$01,$83,$20,$00,$83,$20,$00,$03,$10,$01,$03,$20,$00,$03,$20
	$F053               .byte $00,$83,$70,$04,$83,$20,$00,$83,$20,$00,$00,$70,$04
_DataPointerTableLo_3060
	$F060  00:          .byte < ($0400)
	$F061  03:          .byte < ($0403)
	$F062  00:          .byte < ($0500)
	$F063  05:          .byte < ($0405)
	$F064  00:          .byte < ($0400)
	$F065               .byte $05,$00,$05,$00,$00
_DataPointerTableHi_3060
	$F06A  04:          .byte > ($0400)
	$F06B  04:          .byte > ($0403)
	$F06C  05:          .byte > ($0500)
	$F06D  04:          .byte > ($0405)
	$F06E  04:          .byte > ($0400)
	$F06F               .byte $04,$05,$04,$05,$05
_DataPointerTableLo_3074
	$F074  05:          .byte < ($0305)
	$F075  08:          .byte < ($0308)
	$F076  05:          .byte < ($0405)
	$F077  00:          .byte < ($0400)
	$F078  05:          .byte < ($0305)
	$F079               .byte $00,$05,$00,$05,$05
_DataPointerTableHi_3074
	$F07E  03:          .byte > ($0305)
	$F07F  03:          .byte > ($0308)
	$F080  04:          .byte > ($0405)
	$F081  04:          .byte > ($0400)
	$F082  03:          .byte > ($0305)
	$F083               .byte $04,$04,$04,$04,$04
_func_3088
	$F088  99 A0 03:    sta $03A0,y
	$F08B  99 A4 03:    sta $03A4,y
	$F08E  99 A8 03:    sta $03A8,y
	$F091  99 AC 03:    sta $03AC,y
	$F094  60:          rts 
;------------------------------------------
_func_3095
	$F095  A9 20:       lda #$20
	$F097  85 17:       sta $17
	$F099  A9 55:       lda #$55
	$F09B  85 18:       sta $18
_func_309D
	$F09D  A4 2D:       ldy $2D
	$F09F  B9 D8 F0:    lda _DataPointerTableLo_30D8,y
	$F0A2  85 22:       sta $22
	$F0A4  B9 E2 F0:    lda _DataPointerTableHi_30D8,y
	$F0A7  85 23:       sta $23
	$F0A9  A2 03:       ldx #$03
--	$F0AB  A5 17:       lda $17
	$F0AD  A4 18:       ldy $18
	$F0AF  20 64 E9:    jsr _func_2964
	$F0B2  A0 00:       ldy #$00
-	$F0B4  B1 22:       lda ($22),y
	$F0B6  8D 07 20:    sta PPUDATA
	$F0B9  C8:          iny 
	$F0BA  C0 09:       cpy #$09
	$F0BC  90 F6:       bcc -		; $F0B4
	$F0BE  A5 22:       lda $22
	$F0C0  18:          clc 
	$F0C1  69 09:       adc #$09
	$F0C3  85 22:       sta $22
	$F0C5  90 02:       bcc +		; $F0C9
	$F0C7  E6 23:       inc $23
+	$F0C9  A5 18:       lda $18
	$F0CB  18:          clc 
	$F0CC  69 20:       adc #$20
	$F0CE  85 18:       sta $18
	$F0D0  CA:          dex 
	$F0D1  10 D8:       bpl --		; $F0AB
	$F0D3  A9 00:       lda #$00
	$F0D5  85 C9:       sta $C9
	$F0D7  60:          rts 
;------------------------------------------
_DataPointerTableLo_30D8
	$F0D8  EC:          .byte < (DataTableEntry_30EC)
	$F0D9  10:          .byte < (DataTableEntry_3110)
	$F0DA  34:          .byte < (DataTableEntry_3134)
	$F0DB  58:          .byte < (DataTableEntry_3158)
	$F0DC  7C:          .byte < (DataTableEntry_317C)
	$F0DD               .byte $A0,$C4,$E8,$0C,$30
_DataPointerTableHi_30D8
	$F0E2  F0:          .byte > (DataTableEntry_30EC)
	$F0E3  F1:          .byte > (DataTableEntry_3110)
	$F0E4  F1:          .byte > (DataTableEntry_3134)
	$F0E5  F1:          .byte > (DataTableEntry_3158)
	$F0E6  F1:          .byte > (DataTableEntry_317C)
	$F0E7               .byte $F1,$F1,$F1,$F2,$F2
DataTableEntry_30EC
	$F0EC               .byte $C6,$D9,$C3,$C2,$C3,$C3,$C3,$DA,$2D,$DC,$2D,$2D,$2D,$2D,$2D,$2D
	$F0FC               .byte $C5,$DD,$DE,$2D,$2D,$2D,$2D,$2D,$2D,$C6,$DF,$C5,$D7,$C3,$C3,$C3
	$F10C               .byte $C3,$C3,$D8,$2D
DataTableEntry_3110
	$F110               .byte $CC,$28,$C3,$DA,$C6,$D9,$C3,$DA,$2D,$C4,$2D,$2D,$C7,$D2,$2D,$2D
	$F120               .byte $C5,$DD,$DE,$2D,$C6,$D1,$C5,$D0,$2D,$C6,$DF,$C5,$D7,$D8,$2D,$2D
	$F130               .byte $C5,$D7,$D8,$2D
DataTableEntry_3134
	$F134               .byte $C6,$D9,$C3,$C2,$C3,$C3,$C3,$C3,$CD,$DC,$2D,$C6,$D9,$C3,$CD,$2D
	$F144               .byte $C6,$DF,$DE,$C6,$D1,$CC,$C3,$CF,$C6,$D1,$2D,$C5,$CA,$2D,$CE,$C3
	$F154               .byte $C3,$D8,$2D,$2D
DataTableEntry_3158
	$F158               .byte $2D,$C6,$D9,$C3,$DA,$C6,$D9,$C3,$CD,$2D,$DC,$2D,$2D,$C7,$D2,$2D
	$F168               .byte $2D,$C4,$CC,$D3,$C2,$C3,$D8,$C5,$DD,$C6,$DF,$CE,$CF,$2D,$2D,$2D
	$F178               .byte $2D,$CE,$D8,$2D
DataTableEntry_317C
	$F17C               .byte $CC,$C3,$C3,$C2,$C3,$C3,$C3,$DA,$2D,$CE,$DA,$2D,$CC,$CD,$2D,$2D
	$F18C               .byte $C5,$DD,$2D,$C5,$D7,$CF,$C4,$2D,$2D,$C6,$DF,$2D,$2D,$2D,$2D,$CE
	$F19C               .byte $D8,$D7,$D8,$2D,$2D,$C6,$CB,$C6,$D9,$C3,$C2,$C3,$CD,$C6,$D1,$C7
	$F1AC               .byte $D2,$C8,$D4,$DD,$C6,$DF,$DC,$C6,$D1,$C5,$E1,$DD,$CE,$D8,$2D,$CE
	$F1BC               .byte $D8,$2D,$2D,$CE,$CF,$2D,$2D,$2D,$CC,$28,$C3,$DA,$2D,$CC,$C3,$C3
	$F1CC               .byte $CD,$DE,$2D,$2D,$C5,$D0,$CE,$C3,$CD,$C4,$C5,$DD,$C6,$CB,$C5,$D7
	$F1DC               .byte $C3,$CF,$C4,$2D,$CE,$D8,$C5,$D7,$C3,$C3,$C3,$CF,$CC,$CD,$2D,$2D
	$F1EC               .byte $CC,$C3,$C2,$C3,$CD,$C4,$DE,$D9,$C3,$D3,$CD,$C6,$D9,$CF,$DE,$C6
	$F1FC               .byte $D9,$CD,$C4,$DE,$D6,$2D,$2D,$C5,$CA,$2D,$CE,$CF,$2D,$2D,$2D,$2D
	$F20C               .byte $CC,$28,$C3,$DA,$C8,$D4,$D0,$2D,$2D,$C4,$DB,$D5,$C5,$E2,$DD,$C5
	$F21C               .byte $D0,$2D,$CE,$CF,$DC,$2D,$CE,$E0,$D4,$E2,$DD,$2D,$2D,$CE,$C3,$C3
	$F22C               .byte $D8,$2D,$CE,$CF,$C8,$D4,$DD,$CC,$C3,$C2,$C3,$C3,$CD,$C9,$DD,$CE
	$F23C               .byte $CF,$2D,$CC,$CD,$CC,$CF,$CC,$CF,$C6,$D9,$CD,$DE,$C4,$C4,$2D,$CE
	$F24C               .byte $C3,$D8,$2D,$DE,$D6,$CE,$CF,$2D
_loc_3254
	$F254  A5 56:       lda $56
	$F256  4A:          lsr a
	$F257  4A:          lsr a
	$F258  4A:          lsr a
	$F259  A8:          tay 
	$F25A  B9 96 F2:    lda _DataPointerTableLo_3296,y
	$F25D  85 22:       sta $22
	$F25F  B9 9E F2:    lda _DataPointerTableHi_3296,y
	$F262  85 23:       sta $23
	$F264  A2 08:       ldx #$08
	$F266  C0 08:       cpy #$08
	$F268  B0 24:       bcs +		; $F28E
	$F26A  B9 A6 F2:    lda _data_32A6_indexed,y
	$F26D  85 17:       sta $17
	$F26F  A0 00:       ldy #$00
-	$F271  B1 22:       lda ($22),y
	$F273  9D 00 02:    sta $0200,x
	$F276  9D 00 03:    sta $0300,x
	$F279  E8:          inx 
	$F27A  C8:          iny 
	$F27B  C4 17:       cpy $17
	$F27D  90 F2:       bcc -		; $F271
-	$F27F  E6 56:       inc $56
	$F281  A0 00:       ldy #$00
	$F283  20 08 FF:    jsr _func_3F08
	$F286  A0 80:       ldy #$80
	$F288  20 08 FF:    jsr _func_3F08
	$F28B  4C FF D3:    jmp ----		; $D3FF

+	$F28E  A0 80:       ldy #$80
	$F290  20 08 FF:    jsr _func_3F08
	$F293  4C 7F F2:    jmp -		; $F27F
;------------------------------------------
_DataPointerTableLo_3296
	$F296  AE:          .byte < (DataTableEntry_32AE)
	$F297  AE:          .byte < (DataTableEntry_32AE)
	$F298  D6:          .byte < (DataTableEntry_32D6)
	$F299  0E:          .byte < (DataTableEntry_330E)
	$F29A  D6:          .byte < (DataTableEntry_32D6)
	$F29B  0E:          .byte < (DataTableEntry_330E)
	$F29C  D6:          .byte < (DataTableEntry_32D6)
	$F29D  0E:          .byte < (DataTableEntry_330E)
_DataPointerTableHi_3296
	$F29E  F2:          .byte > (DataTableEntry_32AE)
	$F29F  F2:          .byte > (DataTableEntry_32AE)
	$F2A0  F2:          .byte > (DataTableEntry_32D6)
	$F2A1  F3:          .byte > (DataTableEntry_330E)
	$F2A2  F2:          .byte > (DataTableEntry_32D6)
	$F2A3  F3:          .byte > (DataTableEntry_330E)
	$F2A4  F2:          .byte > (DataTableEntry_32D6)
	$F2A5  F3:          .byte > (DataTableEntry_330E)
_data_32A6_indexed
	$F2A6               .byte $28,$28,$38,$60,$38,$60,$38,$60
DataTableEntry_32AE
	$F2AE               .byte $C0,$A6,$03,$78,$C0,$A6,$43,$80,$C8,$A7,$03,$70,$C8,$A8,$03,$78
	$F2BE               .byte $C8,$A8,$43,$80,$C8,$A7,$43,$88,$D0,$A9,$03,$70,$D0,$AA,$03,$78
	$F2CE               .byte $D0,$AA,$43,$80,$D0,$A9,$43,$88
DataTableEntry_32D6
	$F2D6               .byte $B8,$AB,$03,$78,$B8,$AC,$03,$80,$C0,$AD,$03,$70,$C0,$AE,$03,$78
	$F2E6               .byte $C0,$AF,$03,$80,$C0,$B0,$03,$88,$C8,$B1,$03,$70,$C8,$B2,$03,$78
	$F2F6               .byte $C8,$B3,$03,$80,$C8,$B4,$03,$88,$D0,$B5,$03,$70,$D0,$B6,$03,$78
	$F306               .byte $D0,$B7,$03,$80,$D0,$B8,$03,$88
DataTableEntry_330E
	$F30E               .byte $B0,$B9,$03,$90,$B8,$BA,$03,$70,$B8,$BB,$03,$78,$B8,$BC,$03,$80
	$F31E               .byte $B8,$BD,$03,$88,$B8,$BE,$03,$90,$C0,$BF,$03,$68,$C0,$C0,$03,$70
	$F32E               .byte $C0,$C1,$03,$78,$C0,$C2,$03,$80,$C0,$C3,$03,$88,$C0,$C4,$03,$90
	$F33E               .byte $C8,$C5,$03,$68,$C8,$C6,$03,$70,$C8,$C7,$03,$78,$C8,$C8,$03,$80
	$F34E               .byte $C8,$C9,$03,$88,$C8,$CA,$03,$90,$D0,$CB,$03,$68,$D0,$CC,$03,$70
	$F35E               .byte $D0,$CD,$03,$78,$D0,$CE,$03,$80,$D0,$CF,$03,$88,$D0,$D0,$03,$90
_cleanNT_OAM
	$F36E  20 1B C9:    jsr _queryKeyInput
	$F371  A9 00:       lda #$00
	$F373  85 15:       sta ppumask_state
	$F375  8D 01 20:    sta PPUMASK
	$F378  A5 14:       lda ppuctrl_state
	$F37A  8D 00 20:    sta PPUCTRL
	$F37D  A9 20:       lda #$20
	$F37F  A0 00:       ldy #$00
	$F381  20 64 E9:    jsr _func_2964
	$F384  A9 2D:       lda #$2D
-	$F386  20 FB D0:    jsr _func_10FB
	$F389  C8:          iny 
	$F38A  D0 FA:       bne -		; $F386
	$F38C  20 1B C9:    jsr _queryKeyInput
	$F38F  A9 24:       lda #$24
	$F391  A0 00:       ldy #$00
	$F393  20 64 E9:    jsr _func_2964
	$F396  A9 2D:       lda #$2D
-	$F398  20 FB D0:    jsr _func_10FB
	$F39B  C8:          iny 
	$F39C  D0 FA:       bne -		; $F398
_func_339E
	$F39E  A0 00:       ldy #$00
	$F3A0  A9 F0:       lda #$F0
-	$F3A2  99 00 02:    sta $0200,y
	$F3A5  99 00 03:    sta $0300,y
	$F3A8  C8:          iny 
	$F3A9  D0 F7:       bne -		; $F3A2
	$F3AB  60:          rts 
;------------------------------------------
_func_33AC
	$F3AC  A9 00:       lda #$00
	$F3AE  85 50:       sta $50
	$F3B0  85 51:       sta $51
	$F3B2  85 52:       sta $52
	$F3B4  60:          rts 
;------------------------------------------
_loc_33B5
	$F3B5  A5 B4:       lda $B4
	$F3B7  C9 F0:       cmp #$F0
	$F3B9  90 03:       bcc +		; $F3BE
	$F3BB  4C 69 F4:    jmp ++		; $F469

+	$F3BE  A5 B6:       lda $B6
	$F3C0  D0 0C:       bne +		; $F3CE
	$F3C2  A5 B7:       lda $B7
	$F3C4  C9 C8:       cmp #$C8
	$F3C6  B0 06:       bcs +		; $F3CE
	$F3C8  A5 B7:       lda $B7
	$F3CA  69 02:       adc #$02
	$F3CC  85 B7:       sta $B7
+	$F3CE  A5 B6:       lda $B6
	$F3D0  85 17:       sta $17
	$F3D2  A5 B7:       lda $B7
	$F3D4  0A:          asl a
	$F3D5  26 17:       rol $17
	$F3D7  0A:          asl a
	$F3D8  26 17:       rol $17
	$F3DA  85 18:       sta $18
	$F3DC  A5 B5:       lda $B5
	$F3DE  38:          sec 
	$F3DF  E5 18:       sbc $18
	$F3E1  85 B5:       sta $B5
	$F3E3  A5 B4:       lda $B4
	$F3E5  E5 17:       sbc $17
	$F3E7  85 B4:       sta $B4
	$F3E9  AA:          tax 
	$F3EA  BD 49 E4:    lda _data_2449_indexed,x
	$F3ED  85 17:       sta $17
	$F3EF  8A:          txa 
	$F3F0  4A:          lsr a
	$F3F1  4A:          lsr a
	$F3F2  4A:          lsr a
	$F3F3  A8:          tay 
	$F3F4  BE 49 E5:    ldx _data_2549_indexed,y
	$F3F7  F0 70:       beq ++		; $F469
	$F3F9  BC 0B DD:    ldy _data_1D0B_indexed,x
	$F3FC  B9 17 DD:    lda $DD17,y
	$F3FF  85 22:       sta $22
	$F401  B9 87 DD:    lda $DD87,y
	$F404  85 23:       sta $23
	$F406  B9 21 DE:    lda _data_1E21_indexed,y
	$F409  C0 0E:       cpy #$0E
	$F40B  90 15:       bcc +		; $F422
	$F40D  B9 F7 DD:    lda _data_1DF7_indexed,y
	$F410  C0 2A:       cpy #$2A
	$F412  90 0E:       bcc +		; $F422
	$F414  A9 14:       lda #$14
	$F416  C0 38:       cpy #$38
	$F418  90 08:       bcc +		; $F422
	$F41A  A9 08:       lda #$08
	$F41C  C0 54:       cpy #$54
	$F41E  90 02:       bcc +		; $F422
	$F420  A9 04:       lda #$04
+	$F422  85 18:       sta $18
	$F424  A2 08:       ldx #$08
	$F426  A0 00:       ldy #$00
-	$F428  B1 22:       lda ($22),y
	$F42A  18:          clc 
	$F42B  65 17:       adc $17
	$F42D  9D 00 02:    sta $0200,x
	$F430  9D 00 03:    sta $0300,x
	$F433  C9 50:       cmp #$50
	$F435  B0 08:       bcs +		; $F43F
	$F437  A9 F0:       lda #$F0
	$F439  9D 00 02:    sta $0200,x
	$F43C  9D 00 03:    sta $0300,x
+	$F43F  E8:          inx 
	$F440  C8:          iny 
	$F441  B1 22:       lda ($22),y
	$F443  9D 00 02:    sta $0200,x
	$F446  9D 00 03:    sta $0300,x
	$F449  E8:          inx 
	$F44A  C8:          iny 
	$F44B  B1 22:       lda ($22),y
	$F44D  9D 00 02:    sta $0200,x
	$F450  9D 00 03:    sta $0300,x
	$F453  E8:          inx 
	$F454  C8:          iny 
	$F455  B1 22:       lda ($22),y
	$F457  18:          clc 
	$F458  69 80:       adc #$80
	$F45A  9D 00 02:    sta $0200,x
	$F45D  9D 00 03:    sta $0300,x
	$F460  E8:          inx 
	$F461  C8:          iny 
	$F462  C4 18:       cpy $18
	$F464  90 C2:       bcc -		; $F428
	$F466  4C FF D3:    jmp ----		; $D3FF

++	$F469  A2 08:       ldx #$08
	$F46B  4C FF D3:    jmp ----		; $D3FF
;------------------------------------------
_soundPrepare
	$F46E  A2 00:       ldx #$00
	$F470  8E 11 40:    stx $4011
	$F473  86 BC:       stx $BC
	$F475  CA:          dex 
	$F476  86 B8:       stx $B8
	$F478  86 BD:       stx $BD
	$F47A  86 C2:       stx $C2
	$F47C  A2 0F:       ldx #$0F
	$F47E  8E 15 40:    stx $4015
	$F481  A9 FF:       lda #$FF
-	$F483  9D C0 01:    sta $01C0,x
	$F486  CA:          dex 
	$F487  10 FA:       bpl -		; $F483
	$F489  A5 53:       lda $53
	$F48B  85 BE:       sta $BE
	$F48D  60:          rts 
;------------------------------------------
_setLevelSoundData
	$F48E  AA:          tax 
	$F48F  30 30:       bmi ++		; $F4C1
	$F491  A5 BD:       lda $BD
	$F493  DD DF F4:    cmp _data_34DF_indexed,x
	$F496  B0 01:       bcs +		; $F499
	$F498  60:          rts 

+	$F499  BD DF F4:    lda _data_34DF_indexed,x
	$F49C  85 BD:       sta $BD
	$F49E  C9 1E:       cmp #$1E
	$F4A0  90 05:       bcc +		; $F4A7
	$F4A2  E4 B8:       cpx $B8
	$F4A4  D0 01:       bne +		; $F4A7
	$F4A6  60:          rts 

+	$F4A7  86 B8:       stx $B8
	$F4A9  BD F3 F4:    lda _data_34F3_indexed,x
	$F4AC  85 B9:       sta $B9
	$F4AE  BD FC F4:    lda _data_34FC_indexed,x
	$F4B1  85 BA:       sta $BA
	$F4B3  BD E9 F4:    lda _data_34E9_indexed,x
	$F4B6  85 C2:       sta $C2
	$F4B8  A9 10:       lda #$10
	$F4BA  85 BB:       sta $BB
	$F4BC  A9 01:       lda #$01
	$F4BE  85 BC:       sta $BC
	$F4C0  60:          rts 

++	$F4C1  86 B8:       stx $B8
	$F4C3  E8:          inx 
	$F4C4  86 BC:       stx $BC
	$F4C6  86 BD:       stx $BD
	$F4C8  A9 30:       lda #$30
	$F4CA  8D 00 40:    sta $4000
	$F4CD  8D 04 40:    sta $4004
	$F4D0  8D 0C 40:    sta $400C
	$F4D3  A9 00:       lda #$00
	$F4D5  8D 08 40:    sta $4008
	$F4D8  8D 0A 40:    sta $400A
	$F4DB  8D 0B 40:    sta $400B
	$F4DE  60:          rts 
;------------------------------------------
_data_34DF_indexed
	$F4DF               .byte $32,$28,$28,$28,$28,$28,$28,$2D,$28,$28
_data_34E9_indexed
	$F4E9               .byte $00,$FF,$FF,$FF,$02,$FF,$01,$01,$FF,$FF
_data_34F3_indexed
	$F4F3               .byte $00,$7F,$DB,$1E,$5A,$6C,$A4,$C0,$D1
_data_34FC_indexed
	$F4FC               .byte $00,$F6,$F6,$F8,$FA,$FA,$FA,$FA,$FA
_LevelSoundPlay
	$F505  A9 C0:       lda #$C0
	$F507  8D 17 40:    sta $4017
	$F50A  A5 B8:       lda $B8
	$F50C  F0 1F:       beq ++		; $F52D -> $FAE8
	$F50E  A6 BC:       ldx $BC
	$F510  D0 1E:       bne +++		; $F530
	$F512  C9 08:       cmp #$08
	$F514  D0 0A:       bne +		; $F520
	$F516  A5 32:       lda $32
	$F518  D0 06:       bne +		; $F520
	$F51A  A9 00:       lda #$00
	$F51C  85 B8:       sta $B8
	$F51E  85 C2:       sta $C2
+	$F520  A2 FF:       ldx #$FF
	$F522  86 BD:       stx $BD
	$F524  86 B8:       stx $B8
	$F526  A5 C2:       lda $C2
	$F528  30 03:       bmi ++		; $F52D -> $FAE8
	$F52A  E8:          inx 
	$F52B  86 C2:       stx $C2
++	$F52D  4C E8 FA:    jmp ++++		; $FAE8

+++	$F530  C6 BC:       dec $BC
	$F532  F0 09:       beq +		; $F53D
	$F534  4C E8 FA:    jmp ++++		; $FAE8

---	$F537  E6 B9:       inc $B9
	$F539  D0 02:       bne +		; $F53D
	$F53B  E6 BA:       inc $BA
+ --	$F53D  A0 00:       ldy #$00
	$F53F  B1 B9:       lda ($B9),y
	$F541  29 C0:       and #$C0
	$F543  F0 28:       beq +		; $F56D
	$F545  38:          sec 
	$F546  E9 40:       sbc #$40
	$F548  4A:          lsr a
	$F549  4A:          lsr a
	$F54A  4A:          lsr a
	$F54B  4A:          lsr a
	$F54C  AA:          tax 
	$F54D  B1 B9:       lda ($B9),y
	$F54F  29 3F:       and #$3F
	$F551  0A:          asl a
	$F552  A8:          tay 
	$F553  B9 4F FD:    lda _data_3D4F_indexed,y
	$F556  9D 02 40:    sta $4002,x
	$F559  9D C2 01:    sta $01C2,x
	$F55C  B9 4E FD:    lda _data_3D4E_indexed,y
	$F55F  DD C3 01:    cmp $01C3,x
	$F562  F0 D3:       beq ---		; $F537
	$F564  9D 03 40:    sta $4003,x
	$F567  9D C3 01:    sta $01C3,x
	$F56A  4C 37 F5:    jmp ---		; $F537

+	$F56D  B1 B9:       lda ($B9),y
	$F56F  29 20:       and #$20
	$F571  D0 11:       bne ++		; $F584
	$F573  B1 B9:       lda ($B9),y
	$F575  85 BC:       sta $BC
	$F577  20 7D F5:    jsr _func_357D
	$F57A  4C E8 FA:    jmp ++++		; $FAE8
;------------------------------------------
_func_357D
	$F57D  E6 B9:       inc $B9
	$F57F  D0 02:       bne +		; $F583 -> rts
	$F581  E6 BA:       inc $BA
+	$F583  60:          rts 

++	$F584  B1 B9:       lda ($B9),y
	$F586  29 10:       and #$10
	$F588  D0 13:       bne +		; $F59D
	$F58A  B1 B9:       lda ($B9),y
	$F58C  29 0F:       and #$0F
	$F58E  AA:          tax 
	$F58F  20 7D F5:    jsr _func_357D
	$F592  B1 B9:       lda ($B9),y
	$F594  9D 00 40:    sta $4000,x
	$F597  9D C0 01:    sta $01C0,x
	$F59A  4C 37 F5:    jmp ---		; $F537

+	$F59D  B1 B9:       lda ($B9),y
	$F59F  C9 3F:       cmp #$3F
	$F5A1  D0 1B:       bne +		; $F5BE
	$F5A3  A2 08:       ldx #$08
-	$F5A5  A9 00:       lda #$00
	$F5A7  9D 02 40:    sta $4002,x
	$F5AA  9D C2 01:    sta $01C2,x
	$F5AD  9D 03 40:    sta $4003,x
	$F5B0  A9 FF:       lda #$FF
	$F5B2  9D C3 01:    sta $01C3,x
	$F5B5  CA:          dex 
	$F5B6  CA:          dex 
	$F5B7  CA:          dex 
	$F5B8  CA:          dex 
	$F5B9  10 EA:       bpl -		; $F5A5
	$F5BB  4C 37 F5:    jmp ---		; $F537

+	$F5BE  C9 33:       cmp #$33
	$F5C0  D0 0E:       bne +		; $F5D0
	$F5C2  C8:          iny 
	$F5C3  B1 B9:       lda ($B9),y
	$F5C5  AA:          tax 
	$F5C6  C8:          iny 
	$F5C7  B1 B9:       lda ($B9),y
	$F5C9  86 B9:       stx $B9
	$F5CB  85 BA:       sta $BA
	$F5CD  4C 3D F5:    jmp --		; $F53D

+	$F5D0  C9 34:       cmp #$34
	$F5D2  D0 27:       bne +		; $F5FB
	$F5D4  20 7D F5:    jsr _func_357D
	$F5D7  B1 B9:       lda ($B9),y
	$F5D9  AA:          tax 
	$F5DA  20 7D F5:    jsr _func_357D
	$F5DD  B1 B9:       lda ($B9),y
	$F5DF  48:          pha 
	$F5E0  20 7D F5:     jsr _func_357D
	$F5E3  A4 BB:        ldy $BB
	$F5E5  A5 BA:        lda $BA
	$F5E7  99 CF 01:     sta $01CF,y
	$F5EA  A5 B9:        lda $B9
	$F5EC  99 CE 01:     sta $01CE,y
	$F5EF  C6 BB:        dec $BB
	$F5F1  C6 BB:        dec $BB
	$F5F3  68:          pla 
	$F5F4  86 B9:       stx $B9
	$F5F6  85 BA:       sta $BA
	$F5F8  4C 3D F5:    jmp --		; $F53D

+	$F5FB  C9 35:       cmp #$35
	$F5FD  D0 13:       bne +		; $F612
	$F5FF  E6 BB:       inc $BB
	$F601  E6 BB:       inc $BB
	$F603  A4 BB:       ldy $BB
	$F605  B9 CF 01:    lda $01CF,y
	$F608  85 BA:       sta $BA
	$F60A  B9 CE 01:    lda $01CE,y
	$F60D  85 B9:       sta $B9
	$F60F  4C 3D F5:    jmp --		; $F53D

+	$F612  C9 36:       cmp #$36
	$F614  D0 20:       bne +		; $F636
	$F616  20 7D F5:    jsr _func_357D
	$F619  B1 B9:       lda ($B9),y
	$F61B  A6 BB:       ldx $BB
	$F61D  9D CD 01:    sta $01CD,x
	$F620  20 7D F5:    jsr _func_357D
	$F623  A5 B9:       lda $B9
	$F625  9D CE 01:    sta $01CE,x
	$F628  A5 BA:       lda $BA
	$F62A  9D CF 01:    sta $01CF,x
	$F62D  C6 BB:       dec $BB
	$F62F  C6 BB:       dec $BB
	$F631  C6 BB:       dec $BB
	$F633  4C 3D F5:    jmp --		; $F53D

+	$F636  C9 37:       cmp #$37
	$F638  D0 1D:       bne ++		; $F657
	$F63A  A6 BB:       ldx $BB
	$F63C  DE D0 01:    dec $01D0,x
	$F63F  F0 0D:       beq +		; $F64E
	$F641  BD D1 01:    lda $01D1,x
	$F644  85 B9:       sta $B9
	$F646  BD D2 01:    lda $01D2,x
	$F649  85 BA:       sta $BA
	$F64B  4C 3D F5:    jmp --		; $F53D

+	$F64E  E6 BB:       inc $BB
	$F650  E6 BB:       inc $BB
	$F652  E6 BB:       inc $BB
	$F654  4C 37 F5:    jmp ---		; $F537

++	$F657  29 06:       and #$06
	$F659  0A:          asl a
	$F65A  AA:          tax 
	$F65B  20 7D F5:    jsr _func_357D
	$F65E  B1 B9:       lda ($B9),y
	$F660  10 01:       bpl +		; $F663
	$F662  88:          dey 
+	$F663  18:          clc 
	$F664  7D C2 01:    adc $01C2,x
	$F667  9D 02 40:    sta $4002,x
	$F66A  9D C2 01:    sta $01C2,x
	$F66D  98:          tya 
	$F66E  7D C3 01:    adc $01C3,x
	$F671  DD C3 01:    cmp $01C3,x
	$F674  F0 06:       beq +		; $F67C -> $F537
	$F676  9D 03 40:    sta $4003,x
	$F679  9D C3 01:    sta $01C3,x
+	$F67C  4C 37 F5:    jmp ---		; $F537

	$F67F               .byte $20,$3F,$21,$7F,$24,$3F,$25,$7F,$28,$FF,$3F,$5E,$99,$DB,$06,$7C
	$F68F               .byte $BC,$02,$5E,$99,$06,$3F,$02,$5E,$99,$DB,$06,$7C,$BC,$02,$60,$9D
	$F69F               .byte $D9,$16,$7C,$BC,$02,$5D,$9B,$0E,$7C,$BC,$02,$62,$98,$06,$7C,$BC
	$F6AF               .byte $02,$60,$9D,$D8,$16,$3F,$02,$5D,$9B,$D8,$0E,$3F,$02,$5E,$9B,$D8
	$F6BF               .byte $06,$3F,$02,$60,$9D,$DE,$06,$3F,$02,$62,$A0,$DE,$06,$3F,$02,$63
	$F6CF               .byte $A2,$DE,$06,$3F,$02,$64,$9C,$DD,$1E,$1C,$3F,$00,$20,$3D,$21,$7F
	$F6DF               .byte $24,$3D,$25,$7F,$28,$FF,$34,$EC,$F6,$34,$E5,$F7,$00,$5C,$99,$D5
	$F6EF               .byte $10,$3F,$02,$59,$95,$D0,$0A,$7C,$BC,$02,$5C,$99,$04,$7C,$BC,$02
	$F6FF               .byte $61,$99,$D5,$0C,$61,$9C,$04,$3F,$02,$60,$97,$D4,$0C,$9A,$04,$3F
	$F70F               .byte $02,$5E,$95,$D2,$0A,$7C,$BC,$02,$59,$95,$04,$3F,$02,$59,$95,$CD
	$F71F               .byte $10,$FC,$02,$D2,$06,$7C,$BC,$06,$52,$8D,$04,$3F,$02,$55,$92,$D5
	$F72F               .byte $04,$7C,$BC,$02,$59,$95,$D5,$04,$7C,$BC,$02,$5C,$99,$04,$3F,$02
	$F73F               .byte $5E,$9A,$D7,$10,$3F,$02,$5A,$97,$D2,$0A,$7C,$BC,$02,$5E,$9A,$D2
	$F74F               .byte $04,$3F,$02,$63,$9A,$D7,$0C,$9E,$04,$3F,$02,$61,$9B,$D7,$0C,$9E
	$F75F               .byte $04,$3F,$02,$60,$9C,$DC,$0C,$97,$04,$3F,$02,$5E,$8F,$D7,$0C,$95
	$F76F               .byte $04,$3F,$02,$5C,$94,$DC,$0A,$7C,$BC,$02,$54,$90,$DC,$04,$3F,$02
	$F77F               .byte $57,$94,$D0,$04,$7C,$BC,$02,$5C,$97,$04,$7C,$BC,$02,$60,$9C,$04
	$F78F               .byte $3F,$02,$65,$9D,$D9,$0A,$BC,$02,$9D,$04,$BC,$02,$9D,$04,$BC,$02
	$F79F               .byte $99,$04,$BC,$02,$9D,$04,$3F,$02,$65,$A0,$D9,$0C,$9D,$04,$BC,$02
	$F7AF               .byte $63,$9B,$0C,$9D,$04,$3F,$02,$61,$9E,$DE,$0C,$99,$04,$3F,$02,$60
	$F7BF               .byte $9D,$D9,$0C,$97,$04,$3F,$02,$5E,$95,$DE,$0A,$7C,$BC,$02,$55,$92
	$F7CF               .byte $04,$3F,$02,$59,$95,$DE,$04,$7C,$BC,$02,$5E,$99,$04,$7C,$BC,$02
	$F7DF               .byte $61,$9E,$04,$3F,$02,$35,$63,$8E,$D7,$0C,$9E,$04,$3F,$02,$63,$8E
	$F7EF               .byte $D7,$0A,$7C,$BC,$02,$61,$97,$04,$3F,$02,$60,$9C,$DC,$0C,$60,$97
	$F7FF               .byte $DC,$04
DataTableEntry_3801
	$F801               .byte $3F,$02,$5E,$9A,$D0,$0A,$7C,$BC,$02,$60,$9A,$04,$3F,$02,$61,$99
	$F811               .byte $D5,$10,$FC,$02,$D0,$10,$FC,$02,$D5,$12,$3F,$00,$35,$20,$3E,$21
	$F821               .byte $7F,$24,$7D,$25,$7F,$28,$FF,$3F,$34,$57,$F8,$34,$8A,$F8,$34,$C1
	$F831               .byte $F8,$34,$57,$F8,$34,$8A,$F8,$34,$EA,$F8,$34,$17,$F9,$34,$64,$F9
	$F841               .byte $34,$17,$F9,$34,$B1,$F9,$34,$57,$F8,$34,$8A,$F8,$34,$C1,$F8,$34
	$F851               .byte $57,$F8,$34,$0A,$FA,$00,$63,$A0,$D0,$0F,$3F,$02,$60,$97,$DC,$0A
	$F861               .byte $7C,$BC,$03,$61,$97,$02,$3F,$02,$60,$98,$DB,$0A,$BC,$03,$94,$02
	$F871               .byte $3F,$02,$5E,$96,$D4,$0A,$BC,$03,$98,$02,$3F,$02,$5C,$99,$D9,$0F
	$F881               .byte $3F,$02,$5B,$9B,$DB,$0F,$3F,$02,$35,$59,$9C,$DC,$0A,$7C,$BC,$03
	$F891               .byte $5B,$9E,$02,$3F,$02,$5C,$A0,$D9,$0F,$3F,$02,$5E,$9E,$DE,$0F,$3F
	$F8A1               .byte $02,$60,$9D,$D9,$0A,$BC,$03,$99,$02,$3F,$02,$61,$95,$DE,$0A,$BC
	$F8B1               .byte $03,$99,$02,$3F,$02,$59,$9E,$D2,$0A,$BC,$03,$A1,$02,$3F,$02,$35
	$F8C1               .byte $60,$A0,$D7,$0F,$BC,$FC,$02,$9E,$D6,$0A,$BC,$03,$9C,$02,$3F,$02
	$F8D1               .byte $5E,$9B,$D7,$0A,$BC,$FC,$03,$9C,$D2,$02,$BC,$FC,$02,$9E,$D7,$0A
	$F8E1               .byte $BC,$FC,$03,$97,$DB,$02,$BC,$02,$35,$60,$A0,$D7,$0A,$BC,$03,$97
	$F8F1               .byte $02,$3F,$02,$5E,$99,$D7,$0A,$BC,$03,$9B,$02,$3F,$02,$5C,$9C,$D0
	$F901               .byte $0A,$7C,$BC,$03,$5C,$9C,$02,$3F,$02,$5B,$9B,$DC,$0A,$7C,$BC,$03
	$F911               .byte $5C,$9C,$02,$3F,$02,$35,$5E,$9A,$DA,$0A,$BC,$03,$99,$02,$7C,$BC
	$F921               .byte $02,$5E,$9A,$DA,$0A,$BC,$03,$9E,$02,$3F,$02,$60,$9D,$D9,$0F,$3F
	$F931               .byte $02,$59,$94,$D9,$0A,$7C,$BC,$03,$63,$9D,$02,$3F,$02,$61,$9E,$DE
	$F941               .byte $0A,$BC,$03,$99,$02,$3F,$02,$60,$9D,$D9,$0A,$BC,$03,$97,$02,$3F
	$F951               .byte $02,$5E,$95,$DE,$0A,$BC,$03,$97,$02,$BC,$FC,$02,$5E,$99,$D2,$0F
	$F961               .byte $3F,$02,$35,$60,$9B,$D4,$0F,$3F,$02,$58,$94,$D6,$0A,$7C,$BC,$03
	$F971               .byte $59,$96,$FC,$02,$7C,$BC,$02,$5B,$98,$D8,$0A,$BC,$03,$99,$02,$3F
	$F981               .byte $02,$5E,$9B,$D4,$0A,$BC,$03,$98,$02,$3F,$02,$5C,$99,$D9,$0A,$7C
	$F991               .byte $BC,$03,$5B,$9B,$02,$3F,$02,$5C,$9C,$D4,$0A,$7C,$BC,$03,$5E,$9E
	$F9A1               .byte $02,$3F,$02,$60,$A0,$D9,$0F,$3F,$02,$59,$94,$D0,$0F,$3F,$02,$35
	$F9B1               .byte $5E,$96,$DE,$0A,$7C,$BC,$03,$9D,$94,$02,$3F,$02,$5E,$96,$D9,$0A
	$F9C1               .byte $7C,$BC,$03,$60,$97,$02,$3F,$02,$62,$99,$DE,$0A,$BC,$03,$9B,$02
	$F9D1               .byte $3F,$02,$5E,$9C,$D2,$0F,$3F,$02,$63,$9B,$D7,$0A,$7C,$BC,$03,$5B
	$F9E1               .byte $97,$02,$3F,$02,$5C,$99,$DE,$0A,$7C,$BC,$03,$5B,$9A,$02,$3F,$02
	$F9F1               .byte $5E,$9B,$E3,$0A,$3F,$03,$57,$97,$D7,$02,$3F,$02,$59,$99,$D9,$0A
	$FA01               .byte $3F,$03,$5B,$9B,$DB,$02,$3F,$02,$35,$59,$9C,$DC,$0A,$7C,$BC,$03
	$FA11               .byte $5B,$9E,$02,$3F,$02,$5D,$A0,$D9,$0A,$BC,$03,$A3,$02,$3F,$02,$5E
	$FA21               .byte $A1,$D2,$0A,$BC,$03,$A0,$02,$3F,$02,$61,$9E,$DE,$0A,$BC,$03,$9C
	$FA31               .byte $02,$3F,$02,$5B,$9E,$D7,$0A,$7C,$BC,$03,$57,$9B,$02,$3F,$02,$59
	$FA41               .byte $9C,$D7,$0A,$7C,$BC,$03,$5B,$9E,$02,$3F,$02,$5C,$A0,$DC,$0F,$FC
	$FA51               .byte $02,$D7,$0F,$FC,$02,$D0,$11,$3F,$35,$24,$9D,$25,$7F,$AA,$01,$AC
	$FA61               .byte $01,$A9,$01,$AC,$01,$A9,$01,$AB,$27,$28,$00,$20,$B0,$24,$B0,$28
	$FA71               .byte $00,$2F,$08,$2C,$3C,$2E,$0F,$05,$2C,$30,$01,$2C,$3F,$08,$2C,$3E
	$FA81               .byte $08,$2C,$3D,$08,$2C,$3C,$08,$2C,$3B,$08,$2C,$3A,$08,$2C,$39,$08
	$FA91               .byte $2C,$38,$08,$2C,$37,$08,$2C,$36,$08,$2C,$35,$08,$2C,$34,$08,$2C
	$FAA1               .byte $30,$08,$00,$24,$3F,$25,$7F,$36,$03,$36,$08,$9E,$01,$3A,$04,$01
	$FAB1               .byte $37,$BC,$1E,$12,$37,$36,$20,$AA,$01,$3A,$01,$01,$37,$BC,$00,$24
	$FAC1               .byte $3F,$25,$7F,$9E,$01,$BC,$9D,$01,$BC,$9F,$01,$BC,$A5,$01,$BC,$00
	$FAD1               .byte $3F,$2C,$30,$20,$3F,$70,$05,$6B,$05,$70,$05,$6B,$05,$70,$05,$6B
	$FAE1               .byte $05,$70,$05,$6B,$0A,$3F,$00
++++	$FAE8  A5 C2:       lda $C2
	$FAEA  10 01:       bpl +		; $FAED
	$FAEC  60:          rts 

+	$FAED  A5 53:       lda $53
	$FAEF  C5 BE:       cmp $BE
	$FAF1  D0 09:       bne +		; $FAFC
	$FAF3  A6 51:       ldx $51
	$FAF5  E4 BF:       cpx $BF
	$FAF7  D0 03:       bne +		; $FAFC
	$FAF9  4C 71 FB:    jmp ++		; $FB71

+	$FAFC  85 BE:       sta $BE
	$FAFE  86 BF:       stx $BF
	$FB00  A6 53:       ldx $53
	$FB02  E0 B4:       cpx #$B4
	$FB04  90 02:       bcc +		; $FB08
	$FB06  A2 B4:       ldx #$B4
+	$FB08  A5 5A:       lda $5A
	$FB0A  F0 05:       beq +		; $FB11
	$FB0C  8A:          txa 
	$FB0D  38:          sec 
	$FB0E  E9 0A:       sbc #$0A
	$FB10  AA:          tax 
+	$FB11  BD 2E FC:    lda _data_3C2E_indexed,x
	$FB14  38:          sec 
	$FB15  FD 2F FC:    sbc _data_3C2F_indexed,x
	$FB18  20 15 FC:    jsr _func_3C15
	$FB1B  A9 B4:       lda #$B4
	$FB1D  8D 00 40:    sta $4000
	$FB20  A9 7F:       lda #$7F
	$FB22  8D 01 40:    sta $4001
	$FB25  BD 2E FC:    lda _data_3C2E_indexed,x
	$FB28  38:          sec 
	$FB29  E5 C0:       sbc $C0
	$FB2B  8D 02 40:    sta $4002
	$FB2E  BD 00 01:    lda $0100,x
	$FB31  E9 00:       sbc #$00
	$FB33  CD C3 01:    cmp $01C3
	$FB36  F0 06:       beq +		; $FB3E
	$FB38  8D 03 40:    sta $4003
	$FB3B  8D C3 01:    sta $01C3
+	$FB3E  BD 42 FC:    lda _data_3C42_indexed,x
	$FB41  38:          sec 
	$FB42  FD 43 FC:    sbc _data_3C43_indexed,x
	$FB45  20 15 FC:    jsr _func_3C15
	$FB48  A9 FF:       lda #$FF
	$FB4A  8D 08 40:    sta $4008
	$FB4D  A9 00:       lda #$00
	$FB4F  8D 11 40:    sta $4011
	$FB52  BD 42 FC:    lda _data_3C42_indexed,x
	$FB55  38:          sec 
	$FB56  E5 C0:       sbc $C0
	$FB58  A8:          tay 
	$FB59  BD 14 01:    lda $0114,x
	$FB5C  E9 00:       sbc #$00
	$FB5E  4A:          lsr a
	$FB5F  08:          php 
	$FB60  CD CB 01:     cmp $01CB
	$FB63  F0 06:        beq +		; $FB6B
	$FB65  8D 0B 40:     sta $400B
	$FB68  8D CB 01:     sta $01CB
+	$FB6B  28:          plp 
	$FB6C  98:          tya 
	$FB6D  6A:          ror a
	$FB6E  8D 0A 40:    sta $400A
++	$FB71  A5 C3:       lda $C3
	$FB73  D0 7A:       bne +++		; $FBEF
	$FB75  A5 C2:       lda $C2
	$FB77  F0 01:       beq +		; $FB7A
	$FB79  60:          rts 

+	$FB7A  A5 8F:       lda $8F
	$FB7C  20 E4 FB:    jsr _func_3BE4
	$FB7F  85 C0:       sta $C0
	$FB81  A9 00:       lda #$00
	$FB83  85 C1:       sta $C1
	$FB85  A0 02:       ldy #$02
-	$FB87  B9 8F 00:    lda $008F,y
	$FB8A  20 E4 FB:    jsr _func_3BE4
	$FB8D  C5 C0:       cmp $C0
	$FB8F  B0 04:       bcs +		; $FB95
	$FB91  85 C0:       sta $C0
	$FB93  84 C1:       sty $C1
+	$FB95  88:          dey 
	$FB96  D0 EF:       bne -		; $FB87
	$FB98  A4 C1:       ldy $C1
	$FB9A  B9 8F 00:    lda $008F,y
	$FB9D  C9 F0:       cmp #$F0
	$FB9F  B0 04:       bcs +		; $FBA5
	$FBA1  C9 A8:       cmp #$A8
	$FBA3  B0 06:       bcs ++		; $FBAB
+	$FBA5  A9 B0:       lda #$B0
	$FBA7  8D 04 40:    sta $4004
	$FBAA  60:          rts 

++	$FBAB  38:          sec 
	$FBAC  E9 A8:       sbc #$A8
	$FBAE  AA:          tax 
	$FBAF  BD 06 FD:    lda _data_3D06_indexed,x
	$FBB2  8D 04 40:    sta $4004
	$FBB5  A9 7F:       lda #$7F
	$FBB7  8D 05 40:    sta $4005
	$FBBA  A5 50:       lda $50
	$FBBC  4A:          lsr a
	$FBBD  A5 51:       lda $51
	$FBBF  6A:          ror a
	$FBC0  C9 64:       cmp #$64
	$FBC2  B0 08:       bcs +		; $FBCC
	$FBC4  86 C0:       stx $C0
	$FBC6  A9 48:       lda #$48
	$FBC8  38:          sec 
	$FBC9  E5 C0:       sbc $C0
	$FBCB  AA:          tax 
+	$FBCC  8A:          txa 
	$FBCD  18:          clc 
	$FBCE  69 AC:       adc #$AC
	$FBD0  8D 06 40:    sta $4006
	$FBD3  AD C7 01:    lda $01C7
	$FBD6  C9 01:       cmp #$01
	$FBD8  D0 01:       bne +		; $FBDB
	$FBDA  60:          rts 

+	$FBDB  A9 01:       lda #$01
	$FBDD  8D 07 40:    sta $4007
	$FBE0  8D C7 01:    sta $01C7
	$FBE3  60:          rts 
;------------------------------------------
_func_3BE4
	$FBE4  38:          sec 
	$FBE5  E9 CC:       sbc #$CC
	$FBE7  B0 05:       bcs +		; $FBEE -> rts
	$FBE9  49 FF:       eor #$FF
	$FBEB  18:          clc 
	$FBEC  69 01:       adc #$01
+	$FBEE  60:          rts 

+++	$FBEF  A5 5F:       lda $5F
	$FBF1  D0 01:       bne +		; $FBF4
	$FBF3  60:          rts 

+	$FBF4  AD C3 01:    lda $01C3
	$FBF7  8D 03 40:    sta $4003
	$FBFA  AD CB 01:    lda $01CB
	$FBFD  8D 0B 40:    sta $400B
	$FC00  A9 00:       lda #$00
	$FC02  8D 0C 40:    sta $400C
	$FC05  A9 0E:       lda #<_data_080E
	$FC07  8D 0E 40:    sta $400E
	$FC0A  A9 88:       lda #>_data_080E
	$FC0C  8D 0F 40:    sta $400F
	$FC0F  A9 07:       lda #$07
	$FC11  20 8E F4:    jsr _setLevelSoundData
	$FC14  60:          rts 
;------------------------------------------
_func_3C15
	$FC15  85 C0:       sta $C0
	$FC17  A5 51:       lda $51
	$FC19  29 03:       and #$03
	$FC1B  A8:          tay 
	$FC1C  46 C0:       lsr $C0
	$FC1E  46 C0:       lsr $C0
	$FC20  A5 C0:       lda $C0
-	$FC22  88:          dey 
	$FC23  30 06:       bmi +		; $FC2B
	$FC25  18:          clc 
	$FC26  65 C0:       adc $C0
	$FC28  4C 22 FC:    jmp -		; $FC22

+	$FC2B  85 C0:       sta $C0
	$FC2D  60:          rts 
;------------------------------------------
_data_3C2E_indexed
	$FC2E               .byte $7E
_data_3C2F_indexed
	$FC2F               .byte $63,$48,$2D,$12,$F8,$DF,$C6,$AD,$94,$7C,$64,$4D,$36,$1F,$08,$F2
	$FC3F               .byte $DC,$C7,$B2
_data_3C42_indexed
	$FC42               .byte $9D
_data_3C43_indexed
	$FC43               .byte $88,$74,$60,$4C,$38,$25,$12,$00,$ED,$DB,$C9,$B8,$A6,$95,$85,$74
	$FC53               .byte $64,$53,$44,$34,$24,$15,$06,$F7,$E9,$DA,$CC,$BE,$B1,$A3,$96,$88
	$FC63               .byte $7B,$6F,$62,$56,$49,$3D,$31,$26,$1A,$0F,$03,$F8,$ED,$E3,$D8,$CE
	$FC73               .byte $C3,$B9,$AF,$A5,$9B,$92,$88,$7F,$76,$6D,$64,$5B,$52,$4A,$42,$39
	$FC83               .byte $31,$29,$21,$19,$11,$0A,$02,$FB,$F4,$EC,$E5,$DE,$D8,$D1,$CA,$C3
	$FC93               .byte $BD,$B7,$B0,$AA,$A4,$9E,$98,$92,$8C,$87,$81,$7B,$76,$71,$6B,$66
	$FCA3               .byte $61,$5C,$57,$52,$4D,$48,$43,$3F,$3A,$36,$31,$2D,$28,$24,$20,$1C
	$FCB3               .byte $18,$14,$10,$0C,$08,$04,$00,$FD,$F9,$F5,$F2,$EE,$EB,$E8,$E4,$E1
	$FCC3               .byte $DE,$DB,$D7,$D4,$D1,$CE,$CB,$C8,$C5,$C3,$C0,$BD,$BA,$B8,$B5,$B2
	$FCD3               .byte $B0,$AD,$AB,$A8,$A6,$A3,$A1,$9F,$9C,$9A,$98,$96,$93,$91,$8F,$8D
	$FCE3               .byte $8B,$89,$87,$85,$83,$81,$7F,$7E,$7C,$7A,$78,$76,$75,$73,$71,$70
	$FCF3               .byte $6E,$6D,$6B,$69,$68,$66,$65,$63,$62,$61,$5F
_data_3CFE_indexed
	$FCFE               .byte $FF,$8C,$5C,$40,$2C,$1D,$10,$05
_data_3D06_indexed
	$FD06               .byte $B1,$B1,$B2,$B2,$B3,$B3,$B4,$B4,$B5,$B5,$B6,$B6,$B7,$B7,$B8,$B8
	$FD16               .byte $B9,$B9,$BA,$BA,$BB,$BB,$BC,$BC,$BD,$BD,$BE,$BE,$BF,$BF,$BF,$BF
	$FD26               .byte $BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF
	$FD36               .byte $BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF,$BF
	$FD46               .byte $BF,$BF,$BF,$BF,$BC,$B8,$B4,$B0
_data_3D4E_indexed
	$FD4E               .byte $06
_data_3D4F_indexed
	$FD4F               .byte $AE,$06,$4E,$05,$F3,$05,$9E,$05,$4D,$05,$01,$04,$B9,$04,$75,$04
	$FD5F               .byte $35,$03,$F8,$03,$BF,$03,$89,$03,$57,$03,$27,$02,$F9,$02,$CF,$02
	$FD6F               .byte $A6,$02,$80,$02,$5C,$02,$3A,$02,$1A,$01,$FC,$01,$DF,$01,$C4,$01
	$FD7F               .byte $AB,$01,$93,$01,$7C,$01,$67,$01,$52,$01,$3F,$01,$2D,$01,$1C,$01
	$FD8F               .byte $0C,$00,$FD,$00,$EE,$00,$E1,$00,$D4,$00,$C8,$00,$BD,$00,$B2,$00
	$FD9F               .byte $A8,$00,$9F,$00,$96,$00,$8D,$00,$85,$00,$7E,$00,$76,$00,$70,$00
	$FDAF               .byte $69,$00,$63,$00,$5E,$00,$58,$00,$53,$00,$4F,$00,$4A,$00,$46,$00
	$FDBF               .byte $42,$00,$3E,$00,$24,$00,$20,$00,$00
_loc_3DC8
	$FDC8  A5 C8:       lda $C8
	$FDCA  18:          clc 
	$FDCB  65 5F:       adc $5F
	$FDCD  85 C8:       sta $C8
	$FDCF  C9 02:       cmp #$02
	$FDD1  90 25:       bcc +		; $FDF8
	$FDD3  A9 00:       lda #$00
	$FDD5  85 C8:       sta $C8
	$FDD7  A5 4A:       lda $4A
	$FDD9  18:          clc 
	$FDDA  69 40:       adc #$40
	$FDDC  20 29 FE:    jsr _func_3E29
	$FDDF  18:          clc 
	$FDE0  65 C5:       adc $C5
	$FDE2  85 C5:       sta $C5
	$FDE4  98:          tya 
	$FDE5  65 C4:       adc $C4
	$FDE7  85 C4:       sta $C4
	$FDE9  A5 4A:       lda $4A
	$FDEB  20 29 FE:    jsr _func_3E29
	$FDEE  18:          clc 
	$FDEF  65 C7:       adc $C7
	$FDF1  85 C7:       sta $C7
	$FDF3  98:          tya 
	$FDF4  65 C6:       adc $C6
	$FDF6  85 C6:       sta $C6
+ -	$FDF8  A5 32:       lda $32
	$FDFA  D0 FC:       bne -		; $FDF8
	$FDFC  E6 C9:       inc $C9
	$FDFE  A5 C9:       lda $C9
	$FE00  29 06:       and #$06
	$FE02  D0 04:       bne +		; $FE08
	$FE04  A9 F0:       lda #$F0
	$FE06  D0 02:       bne ++		; $FE0A

+	$FE08  A5 C6:       lda $C6
++	$FE0A  8D 04 02:    sta $0204
	$FE0D  8D 04 03:    sta $0304
	$FE10  A5 C4:       lda $C4
	$FE12  8D 07 02:    sta $0207
	$FE15  8D 07 03:    sta $0307
	$FE18  A9 FC:       lda #$FC
	$FE1A  8D 05 02:    sta $0205
	$FE1D  8D 05 03:    sta $0305
	$FE20  A9 00:       lda #$00
	$FE22  8D 06 02:    sta $0206
	$FE25  8D 06 03:    sta $0306
	$FE28  60:          rts 
;------------------------------------------
_func_3E29
	$FE29  48:          pha 
	$FE2A  29 7F:        and #$7F
	$FE2C  C9 40:        cmp #$40
	$FE2E  90 07:        bcc +		; $FE37
	$FE30  E9 80:        sbc #$80
	$FE32  49 FF:        eor #$FF
	$FE34  18:           clc 
	$FE35  69 01:        adc #$01
+	$FE37  AA:           tax 
	$FE38  A0 00:        ldy #$00
	$FE3A  68:          pla 
	$FE3B  30 04:       bmi +		; $FE41
-	$FE3D  BD 4D FE:    lda _data_3E4D_indexed,x
	$FE40  60:          rts 

+	$FE41  C9 80:       cmp #$80
	$FE43  F0 F8:       beq -		; $FE3D
	$FE45  88:          dey 
	$FE46  A9 00:       lda #$00
	$FE48  38:          sec 
	$FE49  FD 4D FE:    sbc _data_3E4D_indexed,x
	$FE4C  60:          rts 
;------------------------------------------
_data_3E4D_indexed
	$FE4D               .byte $00,$06,$0D,$13,$19,$1F,$26,$2C,$32,$38,$3E,$44,$4A,$50,$56,$5C
	$FE5D               .byte $62,$68,$6D,$73,$79,$7E,$84,$89,$8E,$93,$98,$9D,$A2,$A7,$AC,$B1
	$FE6D               .byte $B5,$B9,$BE,$C2,$C6,$CA,$CE,$D1,$D5,$D8,$DC,$DF,$E2,$E5,$E7,$EA
	$FE7D               .byte $ED,$EF,$F1,$F3,$F5,$F7,$F8,$FA,$FB,$FC,$FD,$FE,$FF,$FF,$FF,$FF
	$FE8D               .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	$FE9D               .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	$FEAD               .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	$FEBD               .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	$FECD               .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	$FEDD               .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	$FEED               .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	$FEFD               .byte $FF,$FF,$FF
DataTableEntry_3F00
	$FF00               .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
_func_3F08
	$FF08  88:          dey 
	$FF09  D0 FD:       bne _func_3F08
_func_3F0B
	$FF0B  60:          rts 
;------------------------------------------
_data_3F0C_indexed
	$FF0C               .byte $00
_DataPointerTableLo_3F0D
	$FF0D  80:          .byte < ($0480)
	$FF0E  80:          .byte < ($0580)
	$FF0F               .byte $00
_data_3F10_indexed
	$FF10               .byte $04
_DataPointerTableHi_3F0D
	$FF11  04:          .byte > ($0480)
	$FF12  05:          .byte > ($0580)
	$FF13               .byte $04
_func_3F14
	$FF14  A4 35:       ldy $35
	$FF16  B9 0C FF:    lda _data_3F0C_indexed,y
	$FF19  85 3A:       sta $3A
	$FF1B  8D 15 06:    sta $0615
	$FF1E  B9 10 FF:    lda _data_3F10_indexed,y
	$FF21  85 3B:       sta $3B
	$FF23  8D 16 06:    sta $0616
	$FF26  B9 0D FF:    lda _DataPointerTableLo_3F0D,y
	$FF29  8D 18 06:    sta $0618
	$FF2C  B9 11 FF:    lda _DataPointerTableHi_3F0D,y
	$FF2F  8D 19 06:    sta $0619
	$FF32  A5 56:       lda $56
	$FF34  C9 01:       cmp #$01
	$FF36  D0 05:       bne +		; $FF3D
	$FF38  A9 05:       lda #$05
	$FF3A  20 8E F4:    jsr _setLevelSoundData
+	$FF3D  A5 71:       lda 游戏演示标志
	$FF3F  C9 01:       cmp #$01
	$FF41  F0 07:       beq +		; $FF4A
	$FF43  A5 32:       lda $32
	$FF45  D0 03:       bne +		; $FF4A
	$FF47  20 05 F5:    jsr _LevelSoundPlay
+	$FF4A  A9 00:       lda #$00
	$FF4C  85 17:       sta $17
	$FF4E  85 18:       sta $18
	$FF50  A9 3E:       lda #$3E
	$FF52  38:          sec 
	$FF53  ED 00 05:    sbc $0500
	$FF56  49 80:       eor #$80
	$FF58  85 1A:       sta $1A
	$FF5A  29 04:       and #$04
	$FF5C  85 19:       sta $19
	$FF5E  A5 15:       lda ppumask_state
	$FF60  F0 0C:       beq +		; $FF6E
-	$FF62  AD 02 20:    lda PPUSTATUS
	$FF65  29 40:       and #$40
	$FF67  F0 F9:       beq -		; $FF62
	$FF69  A0 16:       ldy #$16
	$FF6B  20 08 FF:    jsr _func_3F08
+	$FF6E  A2 00:       ldx #$00
-	$FF70  20 00 06:    jsr $0600
	$FF73  A5 17:       lda $17
                            ; Delay loop begin: 6 cycles (2.0 cycles per byte); ends at $3F78
	$FF75  EA:          nop 
	$FF76  EA:          nop 
	$FF77  EA:          nop 
                            ; End of delay loop (3 bytes)
	$FF78  E0 3A:       cpx #$3A
	$FF7A  90 F4:       bcc -		; $FF70
	$FF7C  20 00 06:    jsr $0600
-	$FF7F  20 00 06:    jsr $0600
	$FF82  A5 17:       lda $17
                            ; Delay loop begin: 6 cycles (2.0 cycles per byte); ends at $3F87
	$FF84  EA:          nop 
	$FF85  EA:          nop 
	$FF86  EA:          nop 
                            ; End of delay loop (3 bytes)
	$FF87  E0 60:       cpx #$60
	$FF89  90 F4:       bcc -		; $FF7F
	$FF8B  20 00 06:    jsr $0600
-	$FF8E  20 00 06:    jsr $0600
	$FF91  A5 17:       lda $17
                            ; Delay loop begin: 6 cycles (2.0 cycles per byte); ends at $3F96
	$FF93  EA:          nop 
	$FF94  EA:          nop 
	$FF95  EA:          nop 
                            ; End of delay loop (3 bytes)
	$FF96  E0 80:       cpx #$80
	$FF98  90 F4:       bcc -		; $FF8E
	$FF9A  60:          rts 
;------------------------------------------
_data_3F9B_indexed
	$FF9B               .byte $A5,$17,$18,$65,$4C,$85,$17,$A5,$18,$65,$4D,$85,$18,$18,$69,$3E
	$FFAB               .byte $38,$FD,$00,$05,$9D,$00,$04,$BD,$00,$04,$A8,$29,$04,$C5,$19,$85
	$FFBB               .byte $19,$D0,$1D,$98,$45,$1A,$30,$14,$EA,$EA,$98,$0A,$8D,$05,$20,$A9
	$FFCB               .byte $00,$8D,$05,$20,$84,$1A,$EA,$EA,$84,$1A,$E8,$60,$98,$4C,$E8,$FF
	$FFDB               .byte $98,$C5,$1A,$B0,$05,$29,$FC,$4C,$E8,$FF,$09,$03,$EA,$0A,$8D,$05
	$FFEB               .byte $20,$A9,$00,$8D,$05,$20,$65,$14,$8D,$00,$20,$84,$1A,$E8,$60,$66
	$FFFB               .byte $C0,$00,$C0,$D2,$C0
