SELECT num_concelho
FROM concelho


concelho onde se fez o maior volume de vendas hoje


selecionar o concelho com mais vendas de todos os conselhos
para cada conselho, somar as vendas de todas as suas instituicoes
para cada instituicao, somar as vendas todas dela 



medico que mais prescreveu no 1º semestre de 2019 em cada região

selecionar para cada regiao 
o medico com mais prescricoes da tabela prescricoes que sejam da mesma regiao 



os medicos que ja prescreveram aspirina em receitas aviadas em todas as farmacias de arouca deste ano

selecionar num_cedula
da tabela prescricao_venda (estas filtradas para serem apenas de Arouca)
onde substancia=aspirina e ano=current_year



doentes que ja fizerqam analises ,mas ainda nao aviaram prescriçoes este mes 

selecionar num_doente
da tabela consulta ^ analise ^ NOT(selecionar num_doente da tab prescricao_venda) 