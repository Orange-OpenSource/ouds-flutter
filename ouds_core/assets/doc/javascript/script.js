
    document.addEventListener("DOMContentLoaded", () => {
    const header = document.querySelector("header#title");
    if (header) {

        // Créer le conteneur pour la partie gauche du header
        const headerLeft = document.createElement('div');
        headerLeft.className = 'header-left';

        // Créer l'image du logo
        const logoImg = document.createElement('img');
        logoImg.src = 'orange_logo.svg';
        logoImg.alt = 'Orange Logo';

        const selfNameSpan = document.querySelector('.self-name');

        if (selfNameSpan) {
          // Mettre à jour le texte
          selfNameSpan.textContent = 'OUDS Flutter';
        }

        // Ajouter l'image et le span dans le conteneur
        headerLeft.appendChild(logoImg);
        headerLeft.appendChild(selfNameSpan);

        // Créer le conteneur pour la version dropdown
        const versionDropdown = document.createElement('div');
        versionDropdown.className = 'version-dropdown';

        // Créer le label
        const label = document.createElement('label');
        label.setAttribute('for', 'version');

        // Créer le select
        const select = document.createElement('select');
        select.id = 'version';

        // Ajouter les options
        const versions = [
          { value: 'index.html', text: 'v0.6.0' },
          { value: 'previousVersions/0.5.0/api/index.html', text: 'v0.5.0' },
          { value: 'previousVersions/0.4.0/api/index.html', text: 'v0.4.0' },
          { value: 'previousVersions/0.3.0/api/index.html', text: 'v0.3.0' },
          { value: 'previousVersions/0.2.0/api/index.html', text: 'v0.2.0' },
          { value: 'previousVersions/0.1.0/api/index.html', text: 'v0.1.0' },
        ];

        versions.forEach(version => {
          const option = document.createElement('option');
          option.value = version.value;
          option.textContent = version.text;
          select.appendChild(option);
        });

        // Ajouter l'événement onchange
        select.onchange = function() {
          if (this.value) {
            window.location.href = this.value;
          }
        };

        // Assembler le tout
        versionDropdown.appendChild(label);
        versionDropdown.appendChild(select);
        header.appendChild(headerLeft);
        header.appendChild(versionDropdown);
    }
    });

              // Créer l'image du banner
        const bannerImg = document.createElement('img');
        bannerImg.src = 'banner.png'; // Chemin vers votre image
        bannerImg.alt = 'Banner Image';
        bannerImg.style.width = '100%';
        bannerImg.style.height = 'auto';

             // Insérer le banner en haut du contenu principal
        const mainContent = document.getElementById('dartdoc-main-content');
        if (mainContent) {
          mainContent.insertAdjacentElement('afterbegin', bannerImg);
        }



            // Sélectionner toutes les sections "section-subtitle"
        document.querySelectorAll('.section-subtitle').forEach((section, index) => {
          // Créer un élément span ou div pour faire office de bouton cliquable
          const toggleBtn = document.createElement('span');
          toggleBtn.textContent = section.textContent; // le texte de la section
          toggleBtn.style.cursor = 'pointer'; // curseur pointeur
          toggleBtn.style.fontWeight = 'bold'; // optionnel : mettre en gras
          toggleBtn.onclick = () => {
            // Trouver tous les éléments suivants jusqu'à la prochaine section ou fin
            let next = section.nextElementSibling;
            while (next && !next.classList.contains('section-title') && !next.classList.contains('section-subtitle')) {
              if (next.tagName.toLowerCase() === 'li') {
                // Toggle la visibilité
                if (next.style.display === 'none') {
                  next.style.display = '';
                } else {
                  next.style.display = 'none';
                }
              }
              next = next.nextElementSibling;
            }
          };
          // Remplacer le texte de la section par le bouton
          section.innerHTML = '';
          section.appendChild(toggleBtn);
        });


         // Parcourir tous les liens dans la liste
        document.querySelectorAll('ol li a').forEach(a => {
          const text = a.textContent;
          const indexOuds = text.indexOf('ouds');
          if (indexOuds !== -1) {
            // Garder uniquement la partie à partir de 'ouds'
            a.textContent = text.substring(indexOuds);
          }
        });

            // Fonction pour convertir snake_case en PascalCase
            function snakeToPascal(str) {
              return str
                .split('_')
                .map(word => word.charAt(0).toUpperCase() + word.slice(1))
                .join('');
            }
            // Parcourir tous les liens dans la liste
            document.querySelectorAll('ol li a').forEach(a => {
              const text = a.textContent;
              const indexOuds = text.indexOf('ouds');
              if (indexOuds !== -1) {
                // Extraire la partie après 'ouds'
                let newText = text.substring(indexOuds); // 'ouds_badge'
                // Supprimer tous les underscores
                newText = newText.replace(/_/g, '_'); // reste le même, on va convertir
                // Convertir en PascalCase
                newText = snakeToPascal(newText);
                // Mettre à jour le texte du lien
                a.textContent = newText;
              }
            });


        // Masquer initialement tous les items sauf les sections
        document.querySelectorAll('.section-subitem').forEach(li => {
          li.style.display = 'none'; // ou 'none' si vous voulez tout cacher au départ
        });
