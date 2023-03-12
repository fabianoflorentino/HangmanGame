# frozen_string_literal: true

# A classe JogoDaForca representa um jogo da forca em Ruby, que tem como objetivo
# adivinhar uma palavra escolhida aleatoriamente pelo computador. A classe possui
# diversas funções que incluem escolher a palavra, jogar o jogo, adivinhar a letra,
# verificar se a letra adivinhada é correta, verificar se o jogo acabou e mostrar
# o estado atual da palavra a ser adivinhada. A classe também contém atributos como
# a palavra a ser adivinhada, as letras erradas já escolhidas pelo jogador, as
# letras corretas já escolhidas pelo jogador e um flag que indica se o jogo acabou
# ou não. O jogo tem um número limitado de tentativas e o jogador pode escolher uma
# letra por vez para tentar adivinhar a palavra. O jogo usa funções privadas para
# desenhar o estado da forca e mostrar o estado atual da palavra a ser adivinhada.
class JogoDaForca
  # Inicializa a classe JogoDaForca com a palavra a ser adivinhada, as letras erradas
  # já escolhidas pelo jogador, as letras corretas já escolhidas pelo jogador e
  # um flag que indica se o jogo acabou ou não.
  def initialize
    @palavra = ['ruby', 'rails', 'javascript', 'python', 'java', 'c', 'c++',
                'c#', 'php', 'swift', 'kotlin', 'go', 'ruby on rails',
                'ruby on rails'].sample.downcase
    @letras_erradas = ''
    @letras_corretas = []
    @fim_de_jogo = false
  end

  # Escolhe aleatoriamente uma palavra da lista de palavras disponíveis.
  def escolher_palavra
    @palavra = @palavra.sample
  end

  # Executa o jogo, desenhando o estado da forca e mostrando o estado atual da
  # palavra a ser adivinhada, permitindo que o jogador adivinhe uma letra por vez
  # até que o jogo acabe.
  def jogar
    until @fim_de_jogo
      desenhar_forca
      mostrar_palavra
      letra = adivinhar_letra
      @letras_corretas << letra if letra_correta?(letra) || @letras_erradas += letra
      verificar_fim_de_jogo
    end
  end

  # Pede ao jogador que digite uma letra e retorna a letra em minúsculas.
  def adivinhar_letra
    puts 'Digite uma letra:'
    gets.chomp.downcase
  end

  # Verifica se a letra adivinhada é correta ou não, comparando com a palavra a
  # ser adivinhada.
  def letra_correta?(letra)
    @palavra.include?(letra)
  end

  # Verifica se o jogo acabou, se o jogador adivinhou todas as letras da palavra
  # ou se o jogador já errou mais de seis vezes.
  def verificar_fim_de_jogo
    # Verifica se o jogador ganhou
    if (letras_restantes - @letras_corretas).empty?
      puts 'Parabéns! Você adivinhou a palavra!'
      mostrar_palavra
      @fim_de_jogo = true
    elsif @letras_erradas.length >= 6
      desenhar_forca
      puts "Você perdeu! A palavra era '#{@palavra}'."
      @fim_de_jogo = true
    end
  end

  private

  # Desenha o estado atual da forca com base no número de letras erradas escolhidas
  # pelo jogador.
  def desenhar_forca
    puts '+---+'
    puts '|   |'
    desenhar_cabeca
    desenhar_corpo
    desenhar_bracos
    desenhar_pernas
    puts '|'
    puts '====='
  end

  # Desenha a cabeça na forca se o jogador já errou pelo menos uma letra.
  def desenhar_cabeca
    puts @letras_erradas.length >= 1 ? '|   O' : '|'
  end

  # Desenha o corpo na forca se o jogador já errou duas letras.
  def desenhar_corpo
    puts '|   |' if @letras_erradas.length == 2
  end

  # Desenha os braços na forca se o jogador já errou três ou mais letras.
  def desenhar_bracos
    arms = puts '|  /|' if @letras_erradas.length == 3
    arms = puts '|  /|\\' if @letras_erradas.length >= 4
    arms
  end

  # Desenha as pernas na forca se o jogador já errou cinco ou mais letras.
  def desenhar_pernas
    legs = puts '|  /' if @letras_erradas.length == 5
    legs = puts '|  / \\' if @letras_erradas.length >= 6
    legs
  end

  # Mostra o estado atual da palavra a ser adivinhada, substituindo as letras
  # não adivinhadas por "_".
  def mostrar_palavra
    palavra_mostrada = ''
    @palavra.split('').each do |letra|
      palavra_mostrada += if @letras_corretas.include?(letra)
                            "#{letra} "
                          else
                            '_ '
                          end
    end
    puts palavra_mostrada
  end

  # Retorna as letras da palavra que ainda não foram adivinhadas.
  def letras_restantes
    @palavra.split('') - @letras_corretas
  end
end
