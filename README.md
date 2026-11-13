# Território Inteligente — Painel de Inteligência Territorial

Aplicativo mobile em Flutter desenvolvido para a **Global Solution 2026** da disciplina *Cross-Platform Application Development* (FIAP).

## Objetivo
Apoiar gestores públicos no acompanhamento de indicadores territoriais por meio de dashboards, tendências e alertas explicáveis. O app **não automatiza decisões de alto impacto**: os alertas são sinais para análise humana.

## Integrantes
| Nome | RM |
|------|----|
| Pedro Mirabella Tonarque | RM 563419 |
| Pedro Henrique Marques | RM 563054 |
| Guilherme Mota Melo | RM 565887 |

## Funcionalidades
- Painel com indicadores de água, energia, resíduos e áreas verdes
- Gráfico de tendência dos últimos 7 dias (dados sintéticos)
- Clima atual de São Paulo (temperatura, umidade e vento) via Open-Meteo, consultado por botão ou *pull-to-refresh*
- Alertas com nível de risco, confiança estimada, justificativa, limitações e ação sugerida
- Marcação de alertas como avaliados pelo gestor
- Cadastro de ocorrências com validação de campos e histórico salvo no dispositivo
- Navegação por quatro áreas: Painel, Alertas, Ocorrências e Sobre

## Tecnologias
Flutter/Dart · Provider (estado) · fl_chart (gráficos) · http (API) · SharedPreferences (persistência local)

## Fontes de dados
- **Clima:** [Open-Meteo Forecast API](https://open-meteo.com/), coordenadas de São Paulo
- **Demais indicadores e séries históricas:** dados sintéticos para demonstração acadêmica, **não oficiais**

## Limitações
- Indicadores de água, energia, resíduos e áreas verdes são demonstrativos.
- O nível de confiança é ilustrativo, sem treinamento ou calibração com dados reais.
- Os alertas não confirmam falhas de infraestrutura nem substituem inspeções.
- A marcação de alerta como avaliado vale apenas durante a sessão e não é salva.
- O clima exige internet; os demais recursos funcionam offline.
- Ocorrências ficam somente no dispositivo, sem sincronização entre usuários.

## Privacidade e uso responsável
O app não solicita dados pessoais identificáveis (nome, telefone ou endereço residencial). Como a descrição da ocorrência é texto livre, recomenda-se não inserir dados pessoais nela. Nenhuma decisão pública é tomada automaticamente.

## Como executar
Pré-requisitos: Flutter SDK (Dart ≥ 3.4) e Android Studio ou VS Code com a extensão Flutter.

```bash
git clone https://github.com/Pedro020108/Territorio-Inteligente.git
cd Territorio-Inteligente
flutter pub get
flutter run
```
Testes: `flutter test`

## Estrutura
```text
lib/
  main.dart
  src/
    models/ providers/ screens/ services/ theme/ widgets/
```
