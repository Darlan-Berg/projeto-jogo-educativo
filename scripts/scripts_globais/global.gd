extends Node

var game_over = false
var diamantes := 0
var score := 0
var vida := 3
var quantidade_vidas := 3
var pedacos_foto := 0
var latex := 0
var fase_em_execucao = null
var current_checkpoint = null

# variável usada para determinar se o player pode ou não se mover
var controles_pausados := false

var posicao_jogador = Vector2.ZERO
var retorno_minigame = false
var qtd_minigames_concluidos = 0
var minigames_concluidos = {
	"acionador_minigame_1": false,
	"acionador_minigame_2": false,
	"acionador_minigame_3": false
}
var inimigos_derrotados = []
var diamantes_coletados = []
var minigame_em_execucao
var pode_iniciar_minigame = false
var ir_para_memorial = false
var interagir = false
