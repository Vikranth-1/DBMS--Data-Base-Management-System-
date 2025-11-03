#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

#define ORDER 4   // Max keys per node = ORDER - 1

struct BPlusTreeNode {
    int keys[ORDER - 1];
    struct BPlusTreeNode* children[ORDER];
    int num_keys;
    int is_leaf;
    struct BPlusTreeNode* next;
};

struct BPlusTreeNode* create_node(int is_leaf) {
    struct BPlusTreeNode* node = (struct BPlusTreeNode*)malloc(sizeof(struct BPlusTreeNode));
    node->is_leaf = is_leaf;
    node->num_keys = 0;
    node->next = NULL;
    for (int i = 0; i < ORDER; i++)
        node->children[i] = NULL;
    return node;
}

void split_child(struct BPlusTreeNode* parent, int index, struct BPlusTreeNode* child) {
    int mid = (ORDER - 1) / 2;
    struct BPlusTreeNode* new_child = create_node(child->is_leaf);
    new_child->num_keys = mid;

    for (int i = 0; i < mid; i++)
        new_child->keys[i] = child->keys[i + mid + 1];

    if (!child->is_leaf) {
        for (int i = 0; i <= mid; i++)
            new_child->children[i] = child->children[i + mid + 1];
    }

    child->num_keys = mid;

    for (int i = parent->num_keys; i > index; i--) {
        parent->children[i + 1] = parent->children[i];
        parent->keys[i] = parent->keys[i - 1];
    }

    parent->children[index + 1] = new_child;
    parent->keys[index] = child->keys[mid];
    parent->num_keys++;
}

void insert_non_full(struct BPlusTreeNode* node, int key) {
    int i = node->num_keys - 1;

    if (node->is_leaf) {
        while (i >= 0 && key < node->keys[i]) {
            node->keys[i + 1] = node->keys[i];
            i--;
        }
        node->keys[i + 1] = key;
        node->num_keys++;
    } else {
        while (i >= 0 && key < node->keys[i]) i--;
        i++;
        if (node->children[i]->num_keys == ORDER - 1) {
            split_child(node, i, node->children[i]);
            if (key > node->keys[i]) i++;
        }
        insert_non_full(node->children[i], key);
    }
}

void insert(struct BPlusTreeNode** root_ref, int key) {
    struct BPlusTreeNode* r = *root_ref;
    if (r->num_keys == ORDER - 1) {
        struct BPlusTreeNode* s = create_node(0);
        *root_ref = s;
        s->children[0] = r;
        split_child(s, 0, r);
        insert_non_full(s, key);
    } else {
        insert_non_full(r, key);
    }
}

int search(struct BPlusTreeNode* node, int key) {
    int i = 0;
    while (i < node->num_keys && key > node->keys[i]) i++;
    if (i < node->num_keys && key == node->keys[i]) return 1;
    if (node->is_leaf) return 0;
    return search(node->children[i], key);
}

void traverse(struct BPlusTreeNode* node) {
    int i;
    for (i = 0; i < node->num_keys; i++) {
        if (!node->is_leaf)
            traverse(node->children[i]);
        printf("%d ", node->keys[i]);
    }
    if (!node->is_leaf)
        traverse(node->children[i]);
}

void free_tree(struct BPlusTreeNode* node) {
    if (node == NULL) return;
    if (!node->is_leaf) {
        for (int i = 0; i <= node->num_keys; i++)
            free_tree(node->children[i]);
    }
    free(node);
}

void main() {
    struct BPlusTreeNode* root = create_node(1);
    int keys[] = {10, 20, 5, 6, 12, 30, 7, 17};
    int n = sizeof(keys) / sizeof(keys[0]);

    clrscr();
    for (int i = 0; i < n; i++)
        insert(&root, keys[i]);

    printf("B+ Tree Traversal:\n");
    traverse(root);
    printf("\n");

    int search_key = 6;
    if (search(root, search_key))
        printf("Key %d found in B+ Tree.\n", search_key);
    else
        printf("Key %d NOT found in B+ Tree.\n", search_key);

    getch();
}
