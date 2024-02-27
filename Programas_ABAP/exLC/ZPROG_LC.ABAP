*&---------------------------------------------------------------------*
*& Report  ZPROG_LC
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zprog_lc MESSAGE-ID zcm01.
*----------------------------------------------------------------------*
*declarando tabela:
TABLES: kna1. "Mestre de clientes (parte geral)"

*----------------------------------------------------------------------*
*declaração types(tipos):
TYPES: BEGIN OF ty_kna1,
         kunnr TYPE kna1-kunnr,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,
         regio TYPE kna1-regio,
         land1 TYPE kna1-land1,
         stras TYPE kna1-stras,
       END OF ty_kna1.

*----------------------------------------------------------------------*
*declaração da workarea (estrutura):
DATA: wa_kna1 TYPE ty_kna1.


*----------------------------------------------------------------------*
*declaração da tabela interna:
DATA: ti_kna1 TYPE STANDARD TABLE OF ty_kna1.

*----------------------------------------------------------------------*
*variaveis:
DATA: v_quant TYPE i.

*----------------------------------------------------------------------*
*tela de seleção

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE text-001.

SELECT-OPTIONS: s_kunnr FOR kna1-kunnr,
                s_land1 FOR kna1-land1.

SELECTION-SCREEN END OF BLOCK b01.

*----------------------------------------------------------------------*
*Inicio do programa( MAIN ).

START-OF-SELECTION.

  PERFORM selecao_dados.

  PERFORM mostra_dados.

END-OF-SELECTION.

*Chamar xd03(visualizar cliente) clicando no codigo do cliente na tabela.
AT LINE-SELECTION.
  SET PARAMETER ID 'KUN' FIELD wa_kna1-kunnr.

  CALL TRANSACTION 'XD03' AND SKIP FIRST SCREEN.

*&---------------------------------------------------------------------*
*&      Form  SELECAO_DADOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM selecao_dados .
*comando que vai ler o banco de dados:
  SELECT kunnr name1 ort01 regio land1 stras
    INTO TABLE ti_kna1
    FROM kna1
    WHERE kunnr IN s_kunnr AND
          land1 IN s_land1.

  IF sy-subrc NE 0.
    MESSAGE i000 WITH 'cliente kna1'.
    STOP.
  ENDIF.


ENDFORM.                    " SELECAO_DADOS
*&---------------------------------------------------------------------*
*&      Form  MOSTRA_DADOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM mostra_dados .

  SORT ti_kna1 BY regio kunnr. " ordena os dados"

  LOOP AT ti_kna1 INTO wa_kna1.

    "quebra pagina por regiao "
    ON CHANGE OF wa_kna1-regio.
      NEW-PAGE.
    ENDON.

    WRITE: / wa_kna1-kunnr HOTSPOT , sy-vline,
            wa_kna1-name1, sy-vline,
            wa_kna1-ort01, sy-vline,
            wa_kna1-regio, sy-vline,
            wa_kna1-land1, sy-vline,
            wa_kna1-stras, sy-vline.

    HIDE wa_kna1-kunnr. "guarda o valor"




*contador:
    ADD 1 TO v_quant.

  ENDLOOP.
  ULINE.
  WRITE: /'foram listados:', v_quant.

ENDFORM.                    " MOSTRA_DADOS
