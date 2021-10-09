{include file="templates/headerBrand.tpl"}

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="login">Login</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="{BASE_URL}">Home</a>
        </li>
        <li class="nav-item"> 
          {foreach from=$title item=$cars}
            <a class="nav-link disabled"  tabindex="-1" aria-disabled="true">{$cars->brand}</a>      
          {/foreach}
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="card-group">
    {foreach from=$carsBrand item=$cars}
        <div class="card" style="max-width: 18rem;">
            <img src="images/cars/supramk4.jpg" class="card-img-top {if $cars->sold} sold {/if}" alt="japonese car">
            <div class="card-body {if $cars->sold} sold {/if}">
                {if !$cars->sold}
                    <h5 class="card-title"><a href="description/{$cars->id}">{$cars->car}</a></h5>
                    <p class="card-text">{$cars->description|truncate:50}</p>
                    <p class="card-text"><small class="text-muted">Year: {$cars->year}</small></p>
                    <a href="deleteCar/{$cars->brand}/{$cars->id}" class="btn btn-danger">Delete</a>
                    <a href="onSaleCar/{$cars->brand}/{$cars->id}" class="btn btn-primary">Sold</a>
                {else}
                    <h5 class="card-title"><a href="description/{$cars->id}">{$cars->car}</a></h5>
                    <p class="card-text">{$cars->description|truncate:50}</p>
                    <p class="card-text"><small class="text-muted">Year: {$cars->year}</small></p>
                    <a href="deleteCar/{$cars->brand}/{$cars->id}" class="btn btn-danger">Delete</a>
                    <a href="soldCar/{$cars->brand}/{$cars->id}" class="btn btn-primary">Restore</a>
                {/if}           
            </div>
        </div>
    {/foreach}
</div>

{include file="templates/footer.tpl"}