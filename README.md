Questão 1

Desenvolver a aplicação na linguagem a qual está buscando a vaga e encaminhar a aplicação e os Fontes para a avaliação.

Uma minhoca está num buraco de 20Cm de profundidade. Ela sobe 5cm por vez e cai 3cm, sendo que cada vez que ela cai, ela pausa 1 segundo. Crie um programa que apresente um quadro amarelo na tela quando ela chegar na metade do caminho e um verde quando ela sair do Buraco. Apresentar também a quantidade de vezes que a minhoca subiu.  

Utilizando o exercício acima, possibilite que o usuário informe a profundidade do buraco, a quantidade que ela avança e a quantidade que ela cai.


Simulador do Desafio da Minhoca (Delphi / VCL)

Aplicação desenvolvida em **Delphi** como parte da avaliação técnica. O projeto simula a progressão de uma minhoca tentando sair de um buraco, controlando os estados visuais da interface gráfica e aplicando conceitos de **Clean Code**, **P.O.O.** e **Separação de Responsabilidades**.

---

## Requisitos do Desafio

1. **Simulação da Minhoca:**
   - Profundidade inicial de 20 cm.
   - Avanço de 5 cm por movimento e queda de 3 cm.
   - Pausa de 1 segundo a cada queda.
   - Exibição de indicador **amarelo** ao atingir metade do trajeto ($10\text{ cm}$).
   - Exibição de indicador **verde** e contador de subidas ao sair do buraco.
2. **Entradas Dinâmicas (Customização):**
   - Permitir ao usuário parametrizar a **profundidade do buraco**, o **avanço por movimento** e a **queda**.

---

## Arquitetura e Boas Práticas

- **Separação em Camadas:** A lógica do model e das regras do problema está encapsulada na classe 'TMinhocaSimulador' (uMinhoca.pas), desvinculada do form visual (uFormPrincipal.pas).
- **Inversão de Controle & Eventos:** A comunicação entre o domínio e a interface gráfica (UI) ocorre por meio de (`TOnProgressoEvent` e `TOnEstadoCoresEvent`), garantindo testabilidade e desacoplamento.
- **Tratamento Defensivo:** Validações de entrada contra loops infinitos (comotaxa de queda maior ou igual ao avanço antes do alcance da saída) e tratamento de numeros apresentados.
- **UI Responsiva:** Atualização do painel e processamento da fila de mensagens do sistema durante os intervalos de pausa.

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- Embarcadero **Delphi** (XE / RAD Studio 10.x / 11 / 12 / CE)
- Suporte a aplicações VCL Win64.

### Passo a Passo
1. Clone o repositório:
   ```bash
   git clone [https://github.com/leandromarqueti/Desafio_Delphi1.git](https://github.com/leandromarqueti/Desafio_Delphi1.git)


Abra o arquivo de projeto .dpr no Delphi.

Compile e execute o projeto (F9).

🧪 Como Usar
Ao abrir a aplicação, os campos virão preenchidos por padrão com o cenário do Exercício 1:

Profundidade: 20

Avanço: 5

Queda: 3

Clique no botão Iniciar Simulação.

Acompanhe a mudança do indicador visual:

🟡 Amarelo: Ativado ao atingir a metade do caminho.

🟢 Verde: Ativado ao concluir a subida e sair do buraco.
