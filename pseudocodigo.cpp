#include <iostream>
#include <vector>

using namespace std;

int main() {
    int a[6] = {111, 222, 333, 444, 555, 666}; //vetor a
    int b[6] = {543, 431, 332, 54, 0, 1}; //vetor b
    int c[6] = {53, 340, 193, 12, 4, 999}; //vetor c
    vector<int> d; //vetor dinamico d, que recebera os valores de a, b, e c que são maiores que vm 
    int mediaa = 0; //media do vetor a
    int mediab = 0; //media do vetor b
    int mediac = 0; //media do vetor c
    int vm = 0; //menor media entre os 3 vetores
    int k = 0; //quantidade de elementos no vetor dinamico d

    for (int i = 0; i < 6; i++) {
        mediaa += a[i];
        mediab += b[i];
        mediac += c[i];
    } // for que adiciona todos os valores dos vetores as suas respectivas medias

    //divide as médias pela quantidade de elementos (6)
    mediaa /= 6;
    mediab /= 6;
    mediac /= 6;

    //acha a menor média e coloca esse valor em vm
    if ((mediaa < mediab) && (mediaa < mediac)) {
        vm = mediaa; 
    }
    if ((mediab < mediaa) && (mediab < mediac)) {
        vm = mediab;
    }
    if ((mediac < mediab) && (mediac < mediaa)) {
        vm = mediac;
    }

    //acha os valores maiores que vm dos vetores e insere eles para o vetor d
    for (int i = 0; i < 6; i++) {
        if (a[i] > vm) {
            d.push_back(a[i]);
        }
        if (b[i] > vm) {
            d.push_back(b[i]);
        }
        if (c[i] > vm) {
            d.push_back(c[i]);
        }
    }
    k = d.size(); //acha o tamanho do vetor d

    //imprime os valores
    cout << "media a = " << mediaa << endl;
    cout << "media b = " << mediab << endl;
    cout << "media c = " << mediac << endl;
    cout << "vm = " << vm << endl;
    for (int i = 0; i < k; i++) {
        cout << "d = " << d[i] << " na posicao " << i << endl;
    }
    cout << "k = " << k << endl;
}