
<%@page import="model.Funcionario"%>
<%@ include file="/login/controleAcesso.jsp"%>
<%@ include file="/estrutura/header.jsp"%>
<%@ include file="/estrutura/menu.jsp"%>

<%@ page import="controller.FuncionarioController"%>
<%@ page import="java.util.List"%>


<%
	int limitePorPagina = 10;
	int paginaAtual;
	if (request.getParameter("pag") != null)
		paginaAtual = Integer.parseInt(request.getParameter("pag"));
	else
		paginaAtual = 1;
%>

<%
	FuncionarioController app = new FuncionarioController();
	List<Funcionario> lista = app.listar(paginaAtual,limitePorPagina);
%>

<div class="container">
	<div class="row">

		<div class="col-md-6">
			<h4>Funcion�rios</h4>
		</div>
		<div class="col-md-6 text-right">
			<a href="<%=request.getContextPath()%>/funcionario/cadastroFuncionario.jsp"
				class="btn waves-effect waves-light indigo tooltipped" data-position="bottom" data-delay="50" data-tooltip="Cadastrar"><i class="mdi-content-add"></i>Incluir</a>
		</div>
		<div class="col-md-12">
			<table class="table hoverable striped responsive-table">
				<thead>
					<th>Nome</th>
					<th>Empresa</th>
					<th>Telefone</th>
					<th>Login</th>
					<th class="mw-200">A��o</th>
				</thead>
				<tbody>
					<%
					if(lista != null)
						for(Funcionario dado : lista) {
					%>
					<tr>
						<td><%= dado.getNome() %> <%= dado.getSobrenome() %></td>
						<td><%= dado.getEmpresa().getNomeFantasia() %></td>
						<td><%= dado.getTelefone() %> / <%= dado.getCelular() %></td>
						<td><%= dado.getEmail()%></td>
						<td class="mw-200">
						<a
							href="<%=request.getContextPath()%>/funcionario/cadastroFuncionario.jsp?id=<%=dado.getId() %>"
							class="btn-floating waves-effect waves-light orange tooltipped" data-position="bottom" data-delay="50" data-tooltip="Editar" >
							<i class="mdi-image-edit"></i></a> 
							
							<a							
							href="<%=request.getContextPath()%>/funcionario/processarFuncionario.jsp?acao=remove&id=<%=dado.getId() %>"
							onclick="return confirmacaoDelecao()" class="btn-floating waves-effect waves-light red tooltipped" data-position="bottom" data-delay="50" data-tooltip="Excluir"
							><i class="mdi-action-delete"></i></a>
						</td>
					</tr>
					<% } %>
				</tbody>

			</table>
		</div>


		<div class="col-md-12 text-center">

			<button onclick="paginaAnterior('<%=request.getContextPath()%>/funcionario/consultaFuncionario.jsp',<%=paginaAtual%>)" type="button"
				<%if (paginaAtual == 1)
				         out.print("disabled"); %>
				class="btn waves-effect waves-light indigo"><i class="mdi-av-fast-rewind"></i> Anterior</button>
			<button onclick="proximaPagina('<%=request.getContextPath()%>/funcionario/consultaFuncionario.jsp',<%=paginaAtual%>)" type="button"
				<%if (lista == null || lista.size() < limitePorPagina)
				         out.print("disabled");
			          else if (lista.size() == 0)
				               out.print("disabled");%>
				class="btn waves-effect waves-light indigo">Pr�xima <i class="mdi-av-fast-forward"></i></button>
		</div>
	</div>
</div>


<%@ include file="/estrutura/footer.jsp"%>