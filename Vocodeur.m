%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VOCODEUR : Programme principal r�alisant un vocodeur de phase 
% et permettant de :
%
% 1- modifier le tempo (la vitesse de "prononciation")
%   sans modifier le pitch (fr�quence fondamentale de la parole)
%
% 2- modifier le pitch 
%   sans modifier la vitesse 
%
% 3- "robotiser" une voix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% R�cup�ration d'un signal audio
%--------------------------------

 [y,Fs]=audioread('Diner.wav');   %signal d'origine
% [y,Fs]=audioread('Extrait.wav');   %signal d'origine
% [y,Fs]=audioread('Halleluia.wav');   %signal d'origine

% Remarque : si le signal est en st�r�o, ne traiter qu'une seule voie � la
% fois
y = y(:,1);

% Courbes (�volution au cours du temps, spectre et spectrogramme)
%--------
% Ne pas oublier de cr�er les vecteurs temps, fr�quences...
% A FAIRE !

% Ecoute
%-------
% A FAIRE !

%%
%-------------------------------
% 1- MODIFICATION DE LA VITESSE
% (sans modification du pitch)
%-------------------------------
% PLUS LENT
rapp = 2/3;   %peut �tre modifi�
ylent = PVoc(y,rapp,1024); 

% Ecoute
%-------
% A FAIRE !


% Courbes
%--------
% A FAIRE !

%
% PLUS RAPIDE
rapp = 3/2;   %peut �tre modifi�
yrapide = PVoc(y,rapp,1024); 


% Ecoute 
%-------
% A FAIRE !

% Courbes
%--------
% A FAIRE !

%%
%----------------------------------
% 2- MODIFICATION DU PITCH
% (sans modification de vitesse)
%----------------------------------
% Param�tres g�n�raux:
%---------------------
% Nombre de points pour la FFT/IFFT
Nfft = 256;

% Nombre de points (longueur) de la fen�tre de pond�ration 
% (par d�faut fen�tre de Hanning)
Nwind = Nfft;

% Augmentation 
%--------------
a = 2;  b = 3;  %peut �tre modifi�
yvoc = PVoc(y, a/b,Nfft,Nwind);

% R�-�chantillonnage du signal temporel afin de garder la m�me vitesse
% A FAIRE !

%Somme de l'original et du signal modifi�
%Attention : on doit prendre le m�me nombre d'�chantillons
%Remarque : vous pouvez mettre un coefficient � ypitch pour qu'il
%intervienne + ou - dans la somme...
% A FAIRE !

% Ecoute
%-------
% A FAIRE !

% Courbes
%--------
% A FAIRE !


%Diminution 
%------------

a = 3;  b = 2;   %peut �tre modifi�
yvoc = PVoc(y, a/b,Nfft,Nwind); 

% R�-�chantillonnage du signal temporel afin de garder la m�me vitesse
% A FAIRE !

%Somme de l'original et du signal modifi�
%Attention : on doit prendre le m�me nombre d'�chantillons
%Remarque : vous pouvez mettre un coefficient � ypitch pour qu'il
%intervienne + ou - dans la somme...
% A FAIRE !

% Ecoute
%-------
% A FAIRE !

% Courbes
%--------
% A FAIRE !


%%
%----------------------------
% 3- ROBOTISATION DE LA VOIX
%-----------------------------
% Choix de la fr�quence porteuse (2000, 1000, 500, 200)
Fc = 500;   %peut �tre modifi�

yrob = Rob(y,Fc,Fs);

% Ecoute
%-------
% A FAIRE !

% Courbes
%-------------
% A FAIRE !

