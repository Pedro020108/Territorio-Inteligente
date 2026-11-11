# Território Inteligente — Painel de Inteligência Territorial

Aplicativo mobile desenvolvido em Flutter para a Global Solution 2026 da disciplina Cross-Platform Application Development (FIAP).

## Objetivo
Apoiar gestores públicos no acompanhamento de indicadores territoriais, apresentando dashboards, tendências e alertas explicáveis. O aplicativo não automatiza decisões de alto impacto.

## Funcionalidades
- Dashboard com indicadores de água, energia, resíduos e áreas verdes.
- Gráfico de tendência semanal com dados sintéticos.
- Consulta de clima atual via Open-Meteo.
- Alertas com nível de risco, confiança estimada, justificativa, limitações e recomendação.
- Marcação de alertas como avaliados pelo gestor.
- Cadastro de ocorrências com validação.
- Histórico persistido localmente com SharedPreferences.
- Navegação por quatro áreas: Painel, Alertas, Ocorrências e Sobre.

## Tecnologias
- Flutter / Dart
- Provider (gerenciamento de estado)
- fl_chart (gráficos)
- http (API)
- SharedPreferences (persistência local)

## Fontes de dados
- **Clima:** Open-Meteo Forecast API, coordenadas de São Paulo: https://open-meteo.com/
- **Água, energia, resíduos, áreas verdes e séries históricas:** dados sintéticos gerados para demonstração acadêmica. Não são dados oficiais.

## Limitações
- Os indicadores de água, energia, resíduos e áreas verdes são demonstrativos.
- O nível de confiança é ilustrativo, não foi treinado ou calibrado com dados históricos reais.
- Os alertas não confirmam falhas de infraestrutura e não substituem inspeções.
- O clima depende de conexão com a internet; os demais recursos funcionam com os dados locais.
- Ocorrências são armazenadas somente no dispositivo e não sincronizam entre usuários.

## Privacidade e uso responsável
O app não solicita dados pessoais identificáveis. Não são coletados nomes, telefones ou endereços residenciais. Alertas servem exclusivamente como apoio à análise humana; nenhuma decisão pública é tomada automaticamente.

## Integrantes
Preencher antes da entrega:
- Pedro Mirabella Tonarque — RM 563419
- Nome completo — RM (preencher se houver segundo integrante)
- Nome completo — RM (preencher se houver terceiro integrante)

## Como executar
1. Instale Flutter SDK e Android Studio (ou VS Code com extensão Flutter).
2. Extraia o projeto.
3. Abra a pasta `territorio_inteligente` no editor.
4. No terminal, dentro da pasta do projeto, execute:

```bash
flutter doctor
flutter pub get
flutter run
```

Para listar dispositivos: `flutter devices`.

## Estrutura
```text
lib/
  main.dart
  src/
    models/
    providers/
    screens/
    services/
    theme/
    widgets/
```

## Evolução por commits
Registre etapas reais de desenvolvimento, sem fazer um único commit com tudo:
1. `chore: cria estrutura inicial do app Flutter`
2. `feat: implementa identidade visual e navegação`
3. `feat: adiciona dashboard e indicadores territoriais`
4. `feat: integra consulta climática com Open-Meteo`
5. `feat: implementa alertas explicáveis`
6. `feat: adiciona cadastro e persistência de ocorrências`
7. `docs: documenta fontes, limitações e privacidade`

## Equipe
O repositório deve conter o código-fonte completo, este README e o histórico de commits dos integrantes.
