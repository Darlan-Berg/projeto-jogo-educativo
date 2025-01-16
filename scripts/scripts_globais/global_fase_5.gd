extends Node

var posicao_jogador = Vector2.ZERO
var retorno_minigame = false
var qtd_minigames_concluidos = 0
var minigames_concluidos = {
	"minigame1": false,
	"minigame2": false,
	"minigame3": false
}
var inimigos_derrotados = []
var minigame_finalizado = null
