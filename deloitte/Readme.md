### Primeiros passos

1. Para rodar a aplicação, clone este repositório e caminhe para o diretório deloitte_challenge;
2. Em seguida, rode o comando `python .\manage.py runserver`. Caso a porta 8000 esteja em uso, você pode setar outra porta para rodar com o comando `python .\manage.py runserver 8080`;
3. Você poderá visualizar a lista de posts em http://127.0.0.1:8080/blog
4. Você poderá ver a lista de serviços em http://127.0.0.1:8080/services
5. Você poderá ver a lista de Funcionários em http://127.0.0.1:8080/staff
6. Você conseguirá acessar o painel de admin em http://127.0.0.1:8080/admin e entrar com as credenciais: usuário: deloitte / senha: dltt124578
7. Neste painel você terá acesso a acessar a lista, criar, editar e deletar posts, serviços e funcionários.

##### Usando API para acessar os dados do banco de dados:

```python
from blog.models import Post
posts = Post.objects.all()
posts
# <QuerySet [<Post: Segundo Artigo do Blog>, <Post: Primeiro Artigo do Blog>]>
post1 = Post.objects.get(id=1) 
post1
# <Post: Primeiro Artigo do Blog>
```

##### Usando API para atualizar dados no banco:

```python
from blog.models import Post
post = Post.objects.get(id=1)
post.title
# 'Primeiro Artigo do Blog'
post.title = "O Primeiro artigo deste Blog!!" 
post.save()
post.title
# O Primeiro artigo deste Blog!!'
```

##### Usando API para filtrar os dados:

```python
Post.objects.filter(author__username='ebraim')
# <QuerySet [<Post: Segundo Artigo do Blog>, <Post: O Primeiro artigo deste Blog!!>]>
```

#### Imagens da aplicação de

Tela de Admin

<img title="Tela de Admin" alt="tela de admin" src="/assets/admin.jpeg">