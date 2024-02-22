*&---------------------------------------------------------------------*
*& Report  ZPROG_EX01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zprog_ex01.

SELECTION-SCREEN BEGIN OF BLOCK bo1 WITH FRAME TITLE text-001.

PARAMETERS: p_aluno(30) TYPE c OBLIGATORY,
            p_curso(30) TYPE c OBLIGATORY DEFAULT 'abap'.

SELECTION-SCREEN END OF BLOCK bo1.

SELECTION-SCREEN BEGIN OF BLOCK bo2 WITH FRAME TITLE text-002.

PARAMETERS: p_apro  RADIOBUTTON GROUP g1,
            p_repro RADIOBUTTON GROUP g1 DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK bo2.

PARAMETERS: p_log AS CHECKBOX DEFAULT 'X',
            p_pro AS CHECKBOX,
            p_fun AS CHECKBOX DEFAULT 'X',
            p_onl AS CHECKBOX.

START-OF-SELECTION.

  WRITE: / 'Nome do Aluno:', p_aluno,
         / 'Curso        :', p_curso.

  SKIP 2.

  IF p_apro = 'X'.
    WRITE: icon_check AS ICON, 'aprovado!'.
  ELSE.
    WRITE: icon_incomplete AS ICON, 'reprovado!'.
  ENDIF.

  IF p_onl = 'X'.
    WRITE: /'verificação online concluida'.
  ELSE.
    WRITE: /'verificação online impossibilitada'.
  ENDIF.


END-OF-SELECTION.
