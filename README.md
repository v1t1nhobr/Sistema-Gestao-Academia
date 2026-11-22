# 🏋️ Sistema de Gestão de Academia

Projeto acadêmico desenvolvido para a disciplina de **Banco de Dados**, do curso de **Análise e Desenvolvimento de Sistemas (ADS)** da **UniRuy Wyden**.

**Aluno:** João Vitor Ferreira da Silva  
**Professor:** Vagner Oliveira  
**Ano:** 2026

---

## 📌 Sobre o projeto

O **Sistema de Gestão de Academia** é um projeto de banco de dados relacional desenvolvido para organizar informações relacionadas à administração de uma academia.

O banco de dados permite armazenar informações sobre usuários, mensalidades, treinos, equipamentos e manutenções.

O projeto foi implementado em **PostgreSQL**, utilizando o **DBeaver** para execução dos scripts e realização dos testes.

## 🎯 Objetivos

- Desenvolver um banco de dados relacional.
- Aplicar conceitos de modelagem e normalização.
- Implementar relacionamentos entre tabelas.
- Utilizar chaves primárias e estrangeiras.
- Garantir a integridade dos dados.
- Desenvolver consultas SQL.
- Implementar mecanismos de segurança para senhas.

## 🛠️ Tecnologias utilizadas

| Tecnologia | Utilização |
|---|---|
| PostgreSQL | Gerenciamento do banco de dados |
| DBeaver | Desenvolvimento e execução dos scripts |
| SQL | Criação, manipulação e consulta dos dados |
| pgcrypto | Geração de hashes de senhas |

## 🗃️ Estrutura do banco de dados

O banco possui **6 tabelas principais**:

| Tabela | Descrição |
|---|---|
| `usuarios` | Cadastro dos usuários |
| `mensalidades` | Controle das mensalidades |
| `treinos` | Registro dos treinos |
| `itens_treino` | Exercícios associados aos treinos |
| `equipamentos` | Cadastro dos equipamentos |
| `manutencoes` | Histórico de manutenção dos equipamentos |

### Relacionamentos

- `usuarios` → `treinos` (1:N)
- `usuarios` → `mensalidades` (1:N)
- `treinos` → `itens_treino` (1:N)
- `equipamentos` → `manutencoes` (1:N)

## 🔐 Segurança e integridade

O banco de dados utiliza:

- **PRIMARY KEY** — identificação única dos registros.
- **FOREIGN KEY** — integridade referencial.
- **NOT NULL** — obrigatoriedade de campos.
- **Restrições de integridade** — validação dos dados.
- **pgcrypto** — armazenamento de hashes de senhas.

Exemplo de geração de hash:

```sql
crypt('senha', gen_salt('bf'))
```

## 📂 Arquivos do projeto

| Arquivo | Descrição |
|---|---|
| `01_ddl_criacao.sql` | Criação das tabelas e restrições |
| `02_dml_insercao.sql` | Inserção de dados fictícios |
| `03_dql_consultas.sql` | Consultas SQL |
| Documentação PDF | Documentação técnica completa |
| DER | Diagrama Entidade-Relacionamento |

## 🔎 Consultas SQL

Foram desenvolvidas **8 consultas SQL**:

| Tipo | Quantidade |
|---|---:|
| Consultas básicas | 2 |
| Consultas com JOIN | 3 |
| Consultas com agregação | 2 |
| Subconsulta | 1 |
| **Total** | **8** |

## 🚀 Como executar

### Pré-requisitos

- PostgreSQL instalado.
- DBeaver ou outro cliente SQL compatível.

### Execução

**1. Crie o banco de dados:**

```sql
CREATE DATABASE academia_eng_software;
```

**2. Conecte-se ao banco criado.**

**3. Execute os scripts na seguinte ordem:**

```text
01_ddl_criacao.sql
02_dml_insercao.sql
03_dql_consultas.sql
```

O primeiro script cria a estrutura do banco, o segundo insere os dados e o terceiro executa as consultas.

## 📊 Resultados

O banco foi implementado e testado no PostgreSQL.

Foram inseridos **30 registros fictícios**, distribuídos entre as seis tabelas, e executadas oito consultas SQL para demonstrar a recuperação de informações.

## 📖 Documentação

A documentação técnica disponibilizada neste repositório apresenta:

- Regras de negócio.
- Modelagem e DER.
- Dicionário de dados.
- Normalização.
- Scripts SQL.
- Consultas e testes.
- Segurança e integridade.

## 👨‍💻 Autor

**João Vitor Ferreira da Silva**

Estudante de Análise e Desenvolvimento de Sistemas — UniRuy Wyden.

**GitHub:** https://github.com/v1t1nhobr

---

**Projeto acadêmico — 2026**
