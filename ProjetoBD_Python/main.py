import apoio_ao_atleta_db  # Importa o módulo que contém as funções relacionadas ao banco de dados

def main():
    # Estabelece conexão com o banco de dados
    connection = apoio_ao_atleta_db.login()  # Consulte apoio_ao_atleta_db.py.py para mais detalhes sobre o login
    
    print(connection)
    tecla_do_usuario = ''  # Inicializa a variável que armazena a escolha do usuário
    if connection:  # Verifica se a conexão foi estabelecida com sucesso
        while(connection):  # Loop principal do programa enquanto a conexão existir
            tecla_do_usuario = input("""
                \033[2J
                \033[H
                BANCO DE DADOS
                APOIO AO ATLETISMO
                Pressione Q para sair
                Pressione A para adicionar um atleta à base de dados 
                pressione O para verificar objetivos de desenvolvimento de um atleta
                Pressione M para verificar os atletas mentorados por um mentor
                Pressione V para verificar atletas com todas as alergias que um atleta tem
                """)
            match tecla_do_usuario.upper():  # Avalia a entrada do usuário
                case 'M':
                    apoio_ao_atleta_db.atletas_mentorados(connection)  # Exibe atletas mentorados
                case 'A':
                    apoio_ao_atleta_db.adicionar_atleta(connection)  # Adiciona um atleta
                case 'O':
                    apoio_ao_atleta_db.objetivos_atleta(connection)  # Exibe objetivos de desenvolvimento
                case 'V':
                    apoio_ao_atleta_db.alergias_semelhantes(connection)  # Verifica se algum atleta possui todas as alergias do atleta inserido pelo usuário
                case 'Q':
                    break  # Sai do loop
                case _:  # Caso padrão para entradas inválidas
                    pass
        connection.cursor().close()  # Fecha o cursor do banco de dados
        connection.close()  # Fecha a conexão com o banco

        print("\033[2J\033[H")  # Limpa a tela do terminal e move o cursor para o inicio da tela
    else:
        print("Não foi possível se conectar à base de dados")  # Mensagem de erro caso a conexão falhe
    

if __name__ == '__main__':
    main()  # Inicia o programa principal
