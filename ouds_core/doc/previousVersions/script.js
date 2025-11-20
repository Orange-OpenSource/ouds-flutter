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